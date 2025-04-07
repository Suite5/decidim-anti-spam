module Decidim
  module SpamSignal
    module Admin
      class ConditionForm < Decidim::Form

        def form_attributes
          attributes.except(:id).keys
        end
      
        mimic :condition

        attribute :name, String
        attribute :settings, Decidim::Form
        attribute :condition_type, String

        validate :valid_condition

        def self.conditional_display
          {}
        end
      
        private

        def valid_condition
          errors.add(:settings, "settings invalid") unless settings.valid?
        end
      end
    end
  end
end