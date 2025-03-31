# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class DummySettingsForm < Decidim::Form
        include Decidim::SpamSignal::SettingsForm
      end
    end
  end
end
