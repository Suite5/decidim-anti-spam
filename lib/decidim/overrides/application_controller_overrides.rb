# frozen_string_literal: true

# This module
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do
      before_action :set_current_continent, :set_current_country

      private

      def set_current_continent
        ::Decidim::SpamSignal.current_continent = request.headers["X-CONTINENT"]
      end

      def set_current_country
        ::Decidim::SpamSignal.current_country = request.headers["X-COUNTRY"]
      end
    end
  end
end
