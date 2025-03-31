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
        Decidim::User.include(
          Decidim::SpamSignal::Flows::ProfileFlow::ProfileValidationFormOverrides
        )
        Decidim::Comments::CommentForm.include(
          Decidim::SpamSignal::Flows::CommentFlow::CommentValidationFormOverrides
        )
      end

      initializer "decidim_spam_signal.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("#{Decidim::SpamSignal::Engine.root}/app/packs")
      end

      config.after_initialize do
        Decidim::SpamSignal.configure do |config|
          config.conditions_registry.register(
            :forbidden_tlds,
            Decidim::SpamSignal::Conditions::ForbiddenTldsSettingsForm,
            Decidim::SpamSignal::Conditions::ForbiddenTldsCommand
          )
          config.conditions_registry.register(
            :allowed_tlds,
            Decidim::SpamSignal::Conditions::AllowedTldsSettingsForm,
            Decidim::SpamSignal::Conditions::AllowedTldsCommand
          )
          config.conditions_registry.register(
            :word,
            Decidim::SpamSignal::Conditions::WordSettingsForm,
            Decidim::SpamSignal::Conditions::WordCommand
          )
          config.actions_registry.register(
            :lock,
            Decidim::SpamSignal::Actions::LockSettingsForm,
            Decidim::SpamSignal::Actions::LockActionCommand
          )
          config.actions_registry.register(
            :report,
            Decidim::SpamSignal::Actions::ReportUserSettingsForm,
            Decidim::SpamSignal::Actions::ReportUserActionCommand
          )
        end
      end
    end
  end
end
