# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsCommand < ConditionHandler
        def call
          return broadcast(:invalid) if continent?

          broadcast(:valid)
        end

        private

        def continent?
          byebug
          true
        end

        
      end
    end
  end
end
