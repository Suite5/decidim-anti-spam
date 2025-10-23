# frozen_string_literal: true

module Decidim
  module SpamSignal
    module OrganizationSpamSignalExtensions
      extend ActiveSupport::Concern

      included do
        has_one :anti_spam_settings,
                class_name: "Decidim::SpamSignal::Settings",
                foreign_key: :decidim_organization_id,
                autosave: true,
                dependent: :destroy

        delegate :anti_spam_mode, to: :anti_spam_settings, allow_nil: true

        def spam_signal_enabled?
          return true unless space_page_defined?
          return true if current_organization.space_page_generator?

          spam_signal_space_enabled?
        end

        def spam_signal_space_enabled?
          current_organization.anti_spam_mode.present? && current_organization.anti_spam_mode != "disable"
        end

        def current_organization
          self
        end

        def space_page_defined?
          Decidim.const_defined?("SpacePage")
        end

        def anti_spam_mode=(value)
          build_anti_spam_settings if anti_spam_settings.nil?
          anti_spam_settings.anti_spam_mode = value
          anti_spam_settings.save
        end
      end
    end
  end
end
