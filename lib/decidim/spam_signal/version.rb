# frozen_string_literal: true

module Decidim
  # This holds the decidim-meetings version.
  module SpamSignal
    def self.version
      "1.0.2"
    end

    def self.decidim_version
      [">= 0.26", "<0.30"].freeze
    end
  end
end
