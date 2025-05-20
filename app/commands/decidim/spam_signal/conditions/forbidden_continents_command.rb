# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsCommand < ConditionHandler
        def call
          return broadcast(:invalid) if forbidden_continent?(continent)

          broadcast(:valid)
        end

        private

        def forbidden_continent?(continent)
          true
        end

        
      end
    end
  end
end
