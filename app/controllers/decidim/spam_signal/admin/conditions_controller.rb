# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class ConditionsController < Decidim::SpamSignal::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasTabbedMenu
        helper_method :conditions, :available_conditions

        add_breadcrumb_item_from_menu :admin_settings_menu

        def tab_menu_name = :admin_spam_signal_menu

        def index
        end
        
        def new
        end

        private

        def conditions
          @conditions ||= Decidim::SpamSignal::Condition.all        
        end
        
      end
    end
  end
end
