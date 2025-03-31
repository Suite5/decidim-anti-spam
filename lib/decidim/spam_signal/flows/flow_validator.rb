# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Flows
      ##
      # Common logics for all the validators
      module FlowValidator
        extend ActiveSupport::Concern
        included do
          validate :detect_spam!
          def detect_spam!
            return if skip_antispam?

            return if flows.empty?

            flows.each do |flow|
              active_conditions = run_conditions(flow.conditions, content_for_antispam)

              next if active_conditions.empty?

              before_antispam
              Decidim::SpamSignal::AntiSpamAction.call(
                flow,
                active_conditions:,
                errors:,
                suspicious_user:,
                suspicious_content: content_for_antispam,
                error_key: spam_error_key
              )
              after_antispam
            end
          end

          def before_antispam; end

          def after_antispam; end

          def antispam_trigger_type
            raise "#{self.class}#antispam_trigger_type not implemented"
          end

          def current_organization
            raise "#{self.class}#current_organization not implemented"
          end

          def suspicious_user
            raise "#{self.class}#suspicious_user not implemented"
          end

          def spam_error_key
            raise "#{self.class}#spam_error_key not implemented"
          end

          def content_for_antispam
            raise "#{self.class}#content_for_antispam not implemented"
          end

          def reportable_content
            raise "#{self.class}#reportable_content not implemented"
          end

          def skip_antispam?
            raise "#{self.class}#skip_antispam? not implemented"
          end

          private

          def flows
            @flows ||= Decidim::SpamSignal::Flow.where(
              trigger_type: antispam_trigger_type,
              organization: current_organization
            ).joins(:conditions)
          end

          def run_conditions(conditions, tested_content)
            active_conditions = conditions.map do |condition|
              result = condition.command.call(
                tested_content,
                condition.settings
              )
              (result || {}).keys.filter { |s| s != :ok && s != :valid }
            end
            active_conditions.flatten
          end
        end
      end
    end
  end
end
