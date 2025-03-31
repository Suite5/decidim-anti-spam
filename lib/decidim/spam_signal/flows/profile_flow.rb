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
            :report
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

            def spam_error_key
              :about
            end

            def reportable_content
              self
            end

            def skip_antispam?
              about.blank? || blocked_at_changed?(from: nil) || blocked_changed?(from: false)
            end

            def resource_spam_config
              @resource_spam_config ||= spam_config.profiles
            end

            def scan_context
              {
                validator: "profile",
                is_updating: true,
                date: updated_at,
                current_organization: organization,
                author: self
              }
            end

            def current_user
              self
            end

            def before_antispam
              restore_values(self)
            end

            # Case the lock cop is there,
            # it will save the user without validation,
            # we should then update the attributes to before
            # state
            def restore_values(user)
              user.about = user.about_was
              user.personal_url = user.personal_url_was
            end
          end
        end
      end
    end
  end
end
