# frozen_string_literal: true

module Decidim
  module SpamSignal
    class Settings < ApplicationRecord
      self.table_name = "anti_spam_settings"
      belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"

      validates :anti_spam_mode, inclusion: { in: %w(disabled enabled_empty enabled_copy) }
    end
  end
end
