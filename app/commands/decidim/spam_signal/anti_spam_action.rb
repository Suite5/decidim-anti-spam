# frozen_string_literal: true

module Decidim
  module SpamSignal
    class AntiSpamAction < Decidim::Command
      attr_reader :flow, :active_conditions, :errors, :suspicious_user, :suspicious_content, :error_key

      def initialize(flow, options)
        @flow = flow
        @errors = options[:errors]
        @suspicious_user = options[:suspicious_user]
        @suspicious_content = options[:suspicious_content]
        @active_conditions = options[:active_conditions]
        @error_key = options[:error_key]
      end

      def call
        # Check available_actions of the flow,
        # and call them with the action_settings
        flow.available_actions.each do |action_name|
          action = Decidim::SpamSignal.config.actions_registry.command_for(action_name)
          action.call(
            errors:,
            suspicious_user:,
            error_key:,
            justification:,
            **flow.action_settings
          )
        end
      end

      private

      def i18n_key
        "decidim.spam_signal.admin.flows.#{flow.trigger_type.demodulize.underscore}"
      end

      def justification
        I18n.t(".justification", count: active_conditions.size, scope: i18n_key)
      end
    end
  end
end
