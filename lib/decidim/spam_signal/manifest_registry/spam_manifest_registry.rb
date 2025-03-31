# frozen_string_literal: true

module Decidim
  module SpamSignal
    module ManifestRegistry
      class SpamManifestRegistry
        attr_reader :manifests

        def initialize
          @manifests = []
        end

        def clear
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
          match = @manifests.find { |manifest| manifest.name.to_s == name.to_s }
          raise Decidim::SpamSignal::Error, "Form '#{name}' not found" unless match

          match.form
        end

        def command_for(name)
          match = @manifests.find { |manifest| manifest.name.to_s == name.to_s }
          raise Decidim::SpamSignal::Error, "Command '#{name}' not found" unless match

          match.command
        end

        def include?(name)
          @manifests.any? { |manifest| manifest.name.to_s == name.to_s }
        end

        def names
          @names ||= @manifests.map(&:name)
        end
      end
    end
  end
end
