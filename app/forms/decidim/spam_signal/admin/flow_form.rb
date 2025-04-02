# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class FlowForm < Decidim::Form
        def form_attributes
          attributes.except(:id).keys
        end
        mimic :flow
        attribute :trigger_type, String
        attribute :name, String

        attribute :conditions, [FlowConditionForm]
        attribute :action_settings, [Decidim::Form]

        validates :name, presence: true
        validates :action_settings, presence: true
        validate :valid_actions

        private

        def valid_actions
          action_settings.all?(&:valid?)
        end
      end
    end
  end
end
