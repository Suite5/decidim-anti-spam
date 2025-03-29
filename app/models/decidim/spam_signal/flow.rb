# frozen_string_literal: true

module Decidim
  module SpamSignal
    class Flow < ApplicationRecord
      self.table_name = "anti_spam_flows"
      belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"
      has_many :conditions, through: :anti_spam_flows_conditions, source: :anti_spam_condition
    end
  end
end
