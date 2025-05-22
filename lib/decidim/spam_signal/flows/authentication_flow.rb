# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Flows
      module AuthenticationFlow
        include ActiveSupport::Configurable
        config_accessor(:available_conditions) do
          [
            :forbidden_continents,
            :forbidden_countries,
            :allowed_countries
          ]
        end

        config_accessor(:available_actions) do
          [
            :hide
          ]
        end
      end
    end
  end
end
