# frozen_string_literal: true

FactoryBot.define do
  factory :spam_signal_condition, class: "Decidim::SpamSignal::Condition" do
    organization { create(:organization) }
    condition_type { "dummy" }
    name { Faker::Lorem.word }
    settings { { foo: "bar" } }
  end
end
