# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class ReportUserActionCommand < ActionCommand
        def call
          report_user!(send_emails: config["send_emails_enabled"])
          broadcast(config["forbid_creation_enabled"] ? :restore_value : :save)
        end
      end
    end
  end
end
