# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Middleware
      class AuthenticationValidation
        # Initializes the Rack Middleware.
        #
        # app - The Rack application
        def initialize(app)
          @app = app
        end

        # Main entry point for a Rack Middleware.
        #
        # env - A Hash.
        def call(env)
          current_organization = env["decidim.current_organization"]
          raise NotFoundError if current_organization.blank?

          current_user = env["warden"]&.user("user") || Decidim::User.new
          # Fire authentication with a dummy active model, to keep the same logic
          # as other flows
          ::Decidim::SpamSignal::Flows::AuthenticationFlow::DummyUser.new(current_organization, current_user).validate
          result = @app.call(env)
          if ::Decidim::SpamSignal.spam_actions_performed.include?(:hide_authentication)
            location = terms_and_conditions(env, current_organization.host)
            return [301, { "Location" => location, "Content-Type" => "text/html", "Content-Length" => "0" }, []]
          else
            result
          end
        end


        private

        def terms_and_conditions(env, host)
          request = Rack::Request.new(env)
          url = URI("/pages/terms-of-service")
          url.host = host
          url.to_s  
        end
      end
    end
  end
end
