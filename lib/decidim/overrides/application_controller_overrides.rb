# frozen_string_literal: true

# This module
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do
      before_action :set_current_continent

      private

      def set_current_continent
        Current.continent = request.headers["X-Continent"]
      end
    end
  end
end
