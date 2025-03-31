# frozen_string_literal: true

module Decidim
  module SpamSignal
    module ManifestRegistry
      class SpamManifest
        attr_reader :name, :form, :command

        def initialize(name, form_class, command_class)
          @name = :"#{name}"

          raise Decidim::SpamSignal::Error, "Form class must inherit from Decidim::Form" unless form_class.is_a?(Class) && form_class.ancestors.include?(Decidim::Form)

          @form = form_class
          unless command_class.is_a?(Class) && command_class.ancestors.include?(Decidim::Command)
            raise Decidim::SpamSignal::Error,
                  "Command class must inherit from Decidim::Command"
          end

          @command = command_class
        end

        def ==(other)
          name.to_s == other.name.to_s
        end
      end
    end
  end
end
