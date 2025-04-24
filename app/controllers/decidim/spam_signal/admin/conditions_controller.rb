# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class ConditionsController < Decidim::SpamSignal::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasTabbedMenu
        helper_method :conditions, :available_conditions

        layout "decidim/admin/settings"

        add_breadcrumb_item_from_menu :admin_settings_menu

        def tab_menu_name = :admin_spam_signal_menu

        def index
        end
        
        def new
          @form = form(ConditionForm).instance
        end

        def condition
        end

        def create
          condition_type = params.require(:condition).require(:condition_type)
          return redirect_to(
            new_condition_path, 
            alert: t("decidim.spam_signal.admin.conditions.create.error")
            ) unless available_conditions.include?(condition_type.to_sym)

          condition = Decidim::SpamSignal::Condition.new(organization: current_organization, condition_type:)
          condition.save(validate: false)
          redirect_to edit_condition_path(condition), notice: t("decidim.spam_signal.admin.conditions.create.success")
        end

        def edit
          @form ||= ConditionForm.from_model(condition)
          @condition_form ||= Decidim::SpamSignal.config.conditions_registry.form_for(condition.condition_type).new(condition.settings)
        end

        def update
          @form = begin 
            form = ConditionForm.from_params(params)
            form.settings = Decidim::SpamSignal.config.conditions_registry.form_for(condition.condition_type).new(params.require(:condition).require(:settings).permit!)
            form
          end
          @condition_form = form.settings
          if @form.valid?
            condition.update!(
              name: @form.name,
              settings: @form.settings.attributes
            )
            return redirect_to edit_condition_path(condition), notice: I18n.t("decidim.spam_signal.admin.conditions.update.success")
          else
            flash.now[:alert] = form.errors.messages[:settings].first
            render :edit
          end
        end

        def destroy

          delete_condition_flow unless conditions_flow.empty?
          condition.delete
          
          render :index
        end

        private

        def condition
          @condition ||= Decidim::SpamSignal::Condition.find(params.require(:id))
        end

        def available_conditions
          @available_conditions ||= Decidim::SpamSignal.config.conditions_registry.names
        end

        def conditions
          @conditions ||= Decidim::SpamSignal::Condition.where(organization: current_organization)
        end

        def conditions_flow
          @conditions_flow = Decidim::SpamSignal::FlowCondition.where(anti_spam_condition_id: condition.id)
        end

        def delete_condition_flow
          conditions_flow.each { |cond_flow| cond_flow.delete }
        end    
      end
    end
  end
end
