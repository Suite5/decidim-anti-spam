# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenCountriesCommand < ConditionHandler
        def call
          return broadcast(:invalid) if forbidden_countries?

          broadcast(:valid)
        end

        private

        def forbidden_countries?
          forbidden_countries_list.include?(Current.country)
        end

        def forbidden_countries_list
          @config["forbidden_countries_list"]
        end
      end 
    end
  end
end
