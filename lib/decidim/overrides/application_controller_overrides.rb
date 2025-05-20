# frozen_string_literal: true

# This module overrides the `update` method in the AccountController.
# By using `prepend` the module's `update` method takes precedence
# over the original method in the controller. 
# It handles the outcome of the update operation through callbacks.
# Additional callback added to the original:
# - On spam detection:
#   - Displays an alert message with the relevant error details.
#   - Redirects the user back to their account page.
module Decidim
  module ApplicationControllerOverrides
    extend ActiveSupport::Concern

    included do 
      before_action :set_current_continent

      private

      def set_current_continent
        Current.continent = request.headers["X-Continent"] = "europe"
      end  
    end
  end
end