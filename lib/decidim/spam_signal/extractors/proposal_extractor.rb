# frozen_string_literal: true

module Decidim
  module SpamSignal
    module Extractors
      class ProposalExtractor < Extractor
        def self.extract(proposal)
          "#{proposal.title} #{proposal.body} #{proposal.address}"
        end
      end
    end
  end
end
