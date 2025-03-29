# frozen_string_literal: true

require "rails"
require "decidim/core"
require "deface"

module Decidim
  module SpamSignal
    # This is the engine that runs on the public interface of spam_signal.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SpamSignal

      config.to_prepare do
        Decidim::User.include(ProfileSpamValidator)
        Decidim::Comments::CommentForm.include(CommentSpamValidator)
      end

      initializer "decidim_spam_signal.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("#{Decidim::SpamSignal::Engine.root}/app/packs")
      end

      config.after_initialize do
        Decidim::SpamSignal.config.conditions_registry.register(
          :forbidden_tlds,
          ::Decidim::SpamSignal::Conditions::ForbiddenTldsSettingsForm,
          ::Decidim::SpamSignal::Conditions::ForbiddenTldsCommand
        )
        Decidim::SpamSignal.config.conditions_registry.register(
          :allowed_tlds,
          ::Decidim::SpamSignal::Conditions::AllowedTldsSettingsForm,
          ::Decidim::SpamSignal::Conditions::AllowedTldsCommand
        )
        Decidim::SpamSignal.config.conditions_registry.register(
          :word,
          ::Decidim::SpamSignal::Conditions::WordSettingsForm,
          ::Decidim::SpamSignal::Conditions::WordCommand
        )
        Decidim::SpamSignal.config.flows_registry.register(
          :lock,
          ::Decidim::SpamSignal::Actions::LockSettingsForm,
          ::Decidim::SpamSignal::Actions::LockActionCommand
        )
        Decidim::SpamSignal.config.flows_registry.register(
          :report_user,
          ::Decidim::SpamSignal::Actions::ReportUserSettingsForm,
          ::Decidim::SpamSignal::Actions::ReportUserActionCommand
        )
      end
    end
  end
end
