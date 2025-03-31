# frozen_string_literal: true

module Decidim
  module SpamSignal
    class FlowCondition < ApplicationRecord
      self.table_name = "anti_spam_flows_conditions"
      belongs_to :anti_spam_flow, class_name: "Decidim::SpamSignal::Flow"
      belongs_to :anti_spam_condition, class_name: "Decidim::SpamSignal::Condition"
    end
  end
end
