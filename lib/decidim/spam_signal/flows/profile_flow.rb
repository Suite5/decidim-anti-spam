# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Flows
      module ProfileFlow
        include ActiveSupport::Configurable
        config_accessor(:available_conditions) do
          [
            :forbidden_tlds,
            :allowed_tlds,
            :word
          ]
        end

        config_accessor(:available_actions) do
          [
            :report,
            :forbid_save
          ]
        end

        module ProfileValidationFormOverrides
          extend ActiveSupport::Concern

          included do
            include ::Decidim::SpamSignal::Flows::FlowValidator
            validate :detect_spam!

            def current_organization
              @current_organization ||= organization
            end

            def antispam_trigger_type
              "Decidim::SpamSignal::Flows::ProfileFlow"
            end

            def content_for_antispam
              @content_for_antispam ||= Extractors::ProfileExtractor.extract(self, spam_config)
            end

            def spam_config
            end 

            def spam_error_key
              :about
            end

            def reportable_content
              self
            end

            ##
            # Skip the flow if no content to test,
            # or if the user is updated to be blocked.
            def skip_antispam?
              (personal_url.blank? && about.blank?) || blocked_at_changed?(from: nil) || blocked_changed?(from: false)
            end

            def suspicious_user
              self
            end

            ##
            # A condition has been met, we restore values
            # before doing actions. As blocking/locking will
            # save the user without validation in the process.
            def before_antispam
              self.about = self.about_was
              self.personal_url = self.personal_url_was
            end
          end
        end
      end
    end
  end
end
