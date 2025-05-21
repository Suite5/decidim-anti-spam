# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm

        attr_reader :forbidden_continents_list

        OPTIONS = [
          ["AF", "Africa"],
          ["AN", "Antarctica"],
          ["AS", "Asia"],
          ["EU", "Europe"],
          ["NA", "North America"],
          ["OC", "Oceania"],
          ["SA", "South America"]
        ].freeze

        attribute :forbidden_continents_list, [String], default: []

        def forbidden_continents_list=(value)
          cleaned = Array(value).map(&:to_s).compact_blank
          super(cleaned)
        end

        def continents
          self.class::OPTIONS
        end
      end
    end
  end
end
