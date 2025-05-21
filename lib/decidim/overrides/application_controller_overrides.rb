# frozen_string_literal: true

# This module
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do 
      before_action :set_current_continent, :set_current_country

      private

      def set_current_continent
        Current.continent = request.headers["X-Continent"]
      end

      def set_current_country
        Current.country = request.headers["X-COUNTRY"]
      end
    end
  end
end
