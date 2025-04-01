# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class FlowConditionForm < Decidim::Form
        def form_attributes
          attributes.except(:id).keys
        end
        mimic :flow_condition
        attribute :condition_id, Integer
        attribute :flow_id, Integer
      end
    end
  end
end
