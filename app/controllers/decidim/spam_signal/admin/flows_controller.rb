# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class FlowsController < ApplicationController
        include Decidim::Admin::Concerns::HasTabbedMenu

        helper_method :flows, :available_flows

        layout "decidim/admin/settings"

        add_breadcrumb_item_from_menu :admin_settings_menu

        def tab_menu_name = :admin_spam_signal_menu

        def index; end

        def new; end

        def edit
          trigger_type = flow.trigger_type.constantize
          actions_form = Decidim::SpamSignal.config.actions_registry.names.filter do |action_name|
            trigger_type.available_actions.include?(action_name)
          end
          actions_form = actions_form.map do |action_name|
            Decidim::SpamSignal.config.actions_registry.form_for(action_name).new(**flat_action_settings(flow.action_settings || {}))
          end
          @form = FlowForm.from_model(flow)
          @form.action_settings = actions_form
        end

        def create
          trigger_type = params.require(:flow).require(:trigger_type)
          return redirect_to new_flow_path, alert: t("decidim.spam_signal.flows.create.error") unless available_flows.include?(trigger_type)

          flow = Decidim::SpamSignal::Flow.new(organization: current_organization, trigger_type:)
          flow.save(validate: false)
          redirect_to edit_flow_path(flow), notice: t("decidim.spam_signal.flows.create.success")
        end

        def update
          trigger_type = flow.trigger_type.constantize
          available_actions = Decidim::SpamSignal.config.actions_registry.names
          actions_form = available_actions.filter do |action_name|
            trigger_type.available_actions.include?(action_name)
          end
          actions_form = actions_form.map do |action_name|
            Decidim::SpamSignal.config.actions_registry.form_for(action_name).from_params(params.require(:flow).require(:action_settings))
          end
          @form = FlowForm.from_params(params)
          @form.action_settings = actions_form
          if @form.valid?
            was_new = flow.invalid?
            flow.update!(
              name: @form.name,
              action_settings: flat_action_settings(@form.action_settings)
            )
            return redirect_to flows_path, notice: t("decidim.spam_signal.flows.create.success") if was_new

            redirect_to edit_flow_path(flow), notice: t("decidim.spam_signal.flows.update.success")
          else
            render :edit
          end
        end

        private

        def flat_action_settings(action_settings_form)
          return action_settings_form.attributes || {} if action_settings_form.is_a?(Decidim::Form)

          action_settings_form.flatten.first || {}
        end

        def flow
          @flow ||= Decidim::SpamSignal::Flow.find(params.require(:id))
        end

        def available_flows
          @available_flows ||= Decidim::SpamSignal.config.available_flows.map(&:name)
        end

        def flows
          @flows ||= Decidim::SpamSignal::Flow.where(organization: current_organization)
        end
      end
    end
  end
end
