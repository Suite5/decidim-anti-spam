# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class ReportUserSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm
        attribute :forbid_creation_enabled, Boolean, default: true
        attribute :send_emails_enabled, Boolean, default: true
      end
    end
  end
end
