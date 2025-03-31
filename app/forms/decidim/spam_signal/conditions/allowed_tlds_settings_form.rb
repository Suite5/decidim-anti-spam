# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class AllowedTldsSettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm
        attribute :allowed_tlds_csv, String
        validates :allowed_tlds_csv, presence: true
      end
    end
  end
end
