# frozen_string_literal: true

module Decidim
  module SpamSignal
    class ApplicationCommand < Decidim::Command
      def self.handler_name
        name.demodulize.underscore.sub(/(_cop|_scan)(_form|_command)/, "")
      end

      def handler_name
        self.class.handler_name
      end

      def self.i18n_key
        raise Error, "Not Implemented"
      end

      def config
        raise Error, "Not Implemented"
      end
    end
  end
end
