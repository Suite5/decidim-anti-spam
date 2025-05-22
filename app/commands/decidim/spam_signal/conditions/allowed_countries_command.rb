# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class AllowedCountriesCommand < ConditionHandler
        def call
          return broadcast(:valid) if allowed_countries?

          broadcast(:invalid)
        end

        private

        def allowed_countries?
          allowed_countries_list.include?(Current.country.to_s.upcase)
        end

        def allowed_countries_list
          @allowed_countries_list ||= config["allowed_countries_list"].map(&:upcase)
        end
      end
    end
  end
end
