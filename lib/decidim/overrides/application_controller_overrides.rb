# frozen_string_literal: true

# This module
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do
      before_action :set_current_continent, :set_current_country

      private

      def set_current_continent
        Current.continent = request.headers["x-continent"]
      end

      def set_current_country
        Current.country = request.headers["x-country"]
      end
    end
  end
end
