# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Actions
      class DummyActionCommand < ActionCommand
        def call
          broadcast(:ok)
        end
      end
    end
  end
end
