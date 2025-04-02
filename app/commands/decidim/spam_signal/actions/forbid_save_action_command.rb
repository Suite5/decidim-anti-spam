# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class ForbidSaveActionCommand < ActionCommand
        def call
          return broadcast(:save) unless config["forbid_save_enabled"]

          errors.add(
            error_key,
            config["forbid_save_message_#{suspicious_user.locale}"]
          )
          broadcast(:restore_value)
        end
      end
    end
  end
end
