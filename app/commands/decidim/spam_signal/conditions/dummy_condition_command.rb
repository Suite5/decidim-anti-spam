# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class DummyConditionCommand < ::Decidim::Command
        def call(form)
          return broadcast(:ok) if form.valid?

          broadcast(:invalid)
        end
      end
    end
  end
end
