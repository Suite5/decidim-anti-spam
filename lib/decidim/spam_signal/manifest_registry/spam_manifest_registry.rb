# frozen_string_literal: true

module Decidim
  module SpamSignal
    module ManifestRegistry
      class SpamManifestRegistry
        attr_reader :manifests

        def initialize
          @manifests = []
        end

        def register(name, form, command)
          raise Decidim::SpamSignal::Error, "Already registered" if include?(name)

          @manifests << SpamManifest.new(name, form, command)
        end

        def unregister(name)
          @manifests.reject! { |manifest| manifest.name.to_s == name.to_s }
        end

        def form_for(name)
          @manifests.find { |manifest| manifest.name.to_s == name.to_s }.form
        end

        def command_for(name)
          @manifests.find { |manifest| manifest.name.to_s == name.to_s }.command
        end

        def include?(name)
          @manifests.any? { |manifest| manifest.name.to_s == name.to_s }
        end
      end
    end
  end
end
