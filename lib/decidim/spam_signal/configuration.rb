# frozen_string_literal: true

module Decidim
  module SpamSignal
    class Configuration
      include ActiveSupport::Configurable
      config_accessor(:conditions_registry) { Decidim::SpamSignal::ManifestRegistry::SpamManifestRegistry.new }
      config_accessor(:actions_registry) { Decidim::SpamSignal::ManifestRegistry::SpamManifestRegistry.new }
    end
  end
end
