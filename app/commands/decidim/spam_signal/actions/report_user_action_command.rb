# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class ReportUserActionCommand < ActionCommand
        def call
          if config["forbid_creation_enabled"]
            errors.add(
              error_key,
              I18n.t("errors.spam",
                     scope: "decidim.spam_signal",
                     default: "this looks like spam.")
            )
          end
          report_user!(send_emails: config["send_emails_enabled"])
          broadcast(config["forbid_creation_enabled"] ? :restore_value : :save)
        end
      end
    end
  end
end
