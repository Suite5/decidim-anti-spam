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

        def invalid? #TODO: check the condition to invalid
          false
        end

        def destroy_condition
          delete_condition_flow unless conditions_flow.empty?
          @condition.delete
        end

        def conditions_flow
          @conditions_flow = Decidim::SpamSignal::FlowCondition.where(anti_spam_condition_id: @condition.id)
        end

        def delete_condition_flow
          conditions_flow.each { |cond_flow| cond_flow.delete }
        end 
      end
    end
  end
end
