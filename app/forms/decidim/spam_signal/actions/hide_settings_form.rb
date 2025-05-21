# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class HideSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm

        attribute :hide_enabled, Boolean, default: true
        translatable_attribute :hide_message, String
        validate :message_present_if_enabled
        add_conditional_display(:hide_message, :hide_enabled)

        private

        def message_present_if_enabled
          errors.add(:hide_message, :blank) if hide_enabled && hide_message.blank?
        end
      end
    end
  end
end
