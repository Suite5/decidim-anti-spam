# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      module ConditionsHelper
        def flow_condition(condition)
          Decidim::SpamSignal::FlowCondition.where(anti_spam_condition_id: condition.id)
        end
      end
    end
  end
end