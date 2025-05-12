# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Flows
      class DestroyFlow < ApplicationCommand
        def initialize(flow)
          @flow = flow
        end
        
        def call
          return broadcast(:invalid) if invalid?

          destroy_flow

          broadcast(:ok)
        end

        private

        def invalid?
          flow_condition.size.positive?
        end

        def destroy_flow
          delete_flow_condition
          @flow.delete
        end

        def delete_flow_condition
          flow_condition.each { |flow_cond| flow_cond.destroy }
        end
        
        def flow_condition
          @flow_condition = Decidim::SpamSignal::FlowCondition.where(anti_spam_flow_id: @flow.id)
        end

      end
    end
  end
end
