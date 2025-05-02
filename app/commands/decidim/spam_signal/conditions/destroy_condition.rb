# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Conditions
      class DestroyCondition < ApplicationCommand
        def initialize(condition)
          @condition = condition
        end
        
        def call
          return broadcast(:invalid) if invalid?

          destroy_condition

          broadcast(:ok)
        end

        private

        def invalid?
          conditions_flow.size.positive?
        end

        def destroy_condition
          delete_condition_flow unless conditions_flow.empty?
          @condition.delete
        end

        def conditions_flow
          @conditions_flow = Decidim::SpamSignal::FlowCondition.where(anti_spam_condition_id: @condition.id)
        end

        def delete_condition_flow
          conditions_flow.each { |cond_flow| cond_flow.destroy }
        end 
      end
    end
  end
end
