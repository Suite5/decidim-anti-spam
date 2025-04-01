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
      end
    end
  end
end
