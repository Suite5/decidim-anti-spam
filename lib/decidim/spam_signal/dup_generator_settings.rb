# frozen_string_literal: true

module Decidim
  module SpamSignal
    # Class to copy settings from one organization to a new organization.
    # Used with the Space Page module, where the organization generator
    # copies its settings to the new single page.
    class DupGeneratorSettings
      def initialize(gen_organization, new_organization)
        @gen_org = gen_organization
        @new_org = new_organization
      end

      def execute_dup
        gen_to_new_conditions = {}

        Decidim::SpamSignal::Condition.where(decidim_organization_id: @gen_org.id).find_each do |condition|
          new_condition = condition.dup
          new_condition.decidim_organization_id = @new_org.id
          new_condition.save!
          gen_to_new_conditions[condition.id] = new_condition
        end

        gen_to_new_flows = {}

        Decidim::SpamSignal::Flow.where(decidim_organization_id: @gen_org.id).find_each do |flow|
          new_flow = flow.dup
          new_flow.decidim_organization_id = @new_org.id
          new_flow.save!
          gen_to_new_flows[flow.id] = new_flow
        end

        Decidim::SpamSignal::FlowCondition.where(anti_spam_flow_id: gen_to_new_flows.keys).find_each do |flow_condition|
          new_flow = gen_to_new_flows[flow_condition.anti_spam_flow_id]
          new_condition = gen_to_new_conditions[flow_condition.anti_spam_condition_id]

          Decidim::SpamSignal::FlowCondition.create!(
            anti_spam_flow_id: new_flow.id,
            anti_spam_condition_id: new_condition.id
          )
        end
      end
    end
  end
end
