# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Flows
      # Aditional validator that get inserted in CommentForm
      # .context is the form context (user, organization, etc)
      # attributes like body are form attributes
      module CommentFlow
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
            :block
          ]
        end

        module CommentValidationFormOverrides
          extend ActiveSupport::Concern

          included do
            include ::Decidim::SpamSignal::Flows::FlowValidator
            validate :detect_spam!

            def antispam_trigger_type
              "Decidim::SpamSignal::Flows::CommentFlow"
            end

            delegate :current_organization, to: :context

            def suspicious_user
              context.author
            end

            def spam_error_key
              :body
            end

            def content_for_antispam
              @content_for_antispam ||= Extractors::CommentExtractor.extract(self, spam_config)
            end

            def skip_antispam?
              body.empty?
            end

            def resource_spam_config
              @resource_spam_config ||= spam_config.comments
            end

            def spam_context
              {
                validator: commentable.commentable_type == "Decidim::Comments::Comment" ? "comment-reply" : "comment",
                is_updating: id.present?,
                date: id.present? ? updated_at : Time.zone.now,
                current_organization: context.current_organization,
                reportable_content: commentable,
                author: context.author
              }
            end
          end
        end
      end
    end
  end
end
