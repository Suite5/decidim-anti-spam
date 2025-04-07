# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class FlowForm < Decidim::Form
        def form_attributes
          attributes.except(:id).keys
        end
        mimic :flow
        attribute :name, String
        attribute :conditions, [FlowConditionForm]
        attribute :action_settings, [Decidim::Form]

        validates :name, presence: true

        validates :action_settings, presence: true
        validate :valid_actions
        validate :valid_conditions

        private

        def valid_actions
          errors.add(:action_settings, "Action settings are empty") unless action_settings.any?
          errors.add(:action_settings, "Action settings are invalid") unless action_settings.all?(&:valid?)
        end

        def valid_conditions
          errors.add(:conditions, "Conditions are empty") unless conditions.any?
          errors.add(:conditions, "Conditions are invalid") unless conditions.all?(&:valid?)
        end

      end
    end
  end
end
