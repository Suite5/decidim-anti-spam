# frozen_string_literal: true

module Decidim
  module SpamSignal
    class FlowCondition < ApplicationRecord
      self.table_name = "anti_spam_flows_conditions"
      belongs_to :flow, foreign_key: :anti_spam_flow_id, class_name: "Decidim::SpamSignal::Flow"
      belongs_to :condition, foreign_key: :anti_spam_condition_id, class_name: "Decidim::SpamSignal::Condition"

      validates :anti_spam_condition_id, uniqueness: { scope: :anti_spam_flow_id }

      def condition_id
        anti_spam_condition_id
      end

      def flow_id
        anti_spam_flow_id
      end
    end
  end
end
