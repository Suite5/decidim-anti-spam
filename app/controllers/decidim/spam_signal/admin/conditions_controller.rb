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
        end

        private

        def available_conditions
          @available_conditions ||= Decidim::SpamSignal.config.conditions_registry.names
        end

        def conditions
          @conditions ||= Decidim::SpamSignal::Condition.where(organization: current_organization)
        end
        
      end
    end
  end
end
