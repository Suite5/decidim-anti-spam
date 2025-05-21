# frozen_string_literal: true

module Decidim
  class Current < ActiveSupport::CurrentAttributes
    attribute :continent
    attribute :country
  end
end
