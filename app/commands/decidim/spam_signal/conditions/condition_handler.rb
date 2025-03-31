# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ConditionHandler < ApplicationCommand
        attr_reader :suspicious_content, :config, :context

        def initialize(suspicious_content, config, context)
          @suspicious_content = suspicious_content
          @config = config
          @context = context
        end

        def self.i18n_key
          "decidim.spam_signal.conditions.#{handler_name}"
        end

      end
    end
  end
end
