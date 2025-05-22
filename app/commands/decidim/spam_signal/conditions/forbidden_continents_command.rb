# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsCommand < ConditionHandler
        def call
          return broadcast(:invalid) if forbidden_continent?

          broadcast(:valid)
        end

        private

        def forbidden_continent?
          forbidden_continents_list.include?(Current.continent.to_s.upcase)
        end

        def forbidden_continents_list
          @forbidden_continents_list ||= config["forbidden_continents_list"].map(&:upcase)
        end
      end
    end
  end
end
