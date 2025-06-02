# frozen_string_literal: true

# This module
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do
      before_action :set_current_continent, :set_current_country

      private

      def set_current_continent
        ::Decidim::SpamSignal.current_continent = request.headers.fetch("CONTINENT", request.headers.fetch("X-Continent", ""))
      end

      def set_current_country
        ::Decidim::SpamSignal.current_country = request.headers.fetch("COUNTRY", request.headers.fetch("X-Country", ""))
      end
    end
  end
end
