# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm
        attribute :is_forbidden_continents_list, Array[String]
        validates :is_forbidden_continents_list, presence: true

        validate :validate_forbidden_continents

        def validate_forbidden_continents
          allowed_continents = %w[europe north_america south_america asia africa oceania antarctica]
          invalid_values = is_forbidden_continents_list - allowed_continents
          if invalid_values.any?
            errors.add(:is_forbidden_continents_list, "contains invalid continents: #{invalid_values.join(', ')}")
          end
        end
        
      end
    end
  end
end
