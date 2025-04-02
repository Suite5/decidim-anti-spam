# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Admin
      class SpamSignalsController < Decidim::SpamSignal::Admin::ApplicationController
        include FormFactory
        helper Decidim::SpamSignal::Admin::SpamSignalHelper
        
        def show
        end
        
      end
    end
  end
end
