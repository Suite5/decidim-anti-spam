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
  module AccountControllerOverrides
    extend ActiveSupport::Concern

    prepended do 
      def update
        enforce_permission_to(:update, :user, current_user:)
        @account = form(AccountForm).from_params(account_params)
        UpdateAccount.call(@account) do
          on(:ok) do |email_is_unconfirmed|
            flash[:notice] = if email_is_unconfirmed
                              t("account.update.success_with_email_confirmation", scope: "decidim")
                            else
                              t("account.update.success", scope: "decidim")
                            end

            bypass_sign_in(current_user)
            redirect_to account_path(locale: current_user.reload.locale)
          end

          on(:invalid) do |password|
            fetch_entered_password(password)
            flash[:alert] = t("account.update.error", scope: "decidim")
            render action: :show
          end

          # Add the broadcast condition for spam_signal
          on(:spam_detected) do |errors|
            flash[:alert] = errors[:about].join(" / ")
            redirect_to account_path(locale: current_user.reload.locale)
          end
        end
      end
    end
  end
end