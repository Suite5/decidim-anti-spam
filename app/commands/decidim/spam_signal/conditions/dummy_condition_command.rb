# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class DummyConditionCommand < ConditionHandler
        def call
          return broadcast(:ok) if suspicious_content == "true"

          broadcast(:invalid)
        end
      end
    end
  end
end
