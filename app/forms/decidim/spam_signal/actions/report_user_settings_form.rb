# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class ReportUserSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm

        attribute :report_user_enabled, Boolean, default: true
        translatable_attribute :report_user_justification, String

        attribute :report_user_send_emails_enabled, Boolean, default: true
        attribute :report_user_send_email_to, String

        add_conditional_display(:report_user_justification, :report_user_enabled)
        add_conditional_display(:report_user_send_email_to, :report_user_send_emails_enabled)
      end
    end
  end
end
