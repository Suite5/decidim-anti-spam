# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class ForbiddenContinentsSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm

        attr_reader :forbidden_continents_list

        OPTIONS = %w(europe north_america south_america asia africa oceania antarctica).freeze

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
