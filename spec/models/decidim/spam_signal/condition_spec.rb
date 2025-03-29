# frozen_string_literal: true

require "spec_helper"

describe Decidim::SpamSignal::Condition do
  Decidim::SpamSignal.configure do |config|
    config.conditions_registry.register(
      "dummy",
      Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
      Decidim::SpamSignal::Conditions::DummyConditionCommand
    )
  end
  subject { described_class.new(organization:, name: "dummy", settings: {}, condition_type: "dummy") }

  let(:organization) { create(:organization) }

  it "has a valid factory" do
    expect(build(:spam_signal_condition)).to be_valid
  end

  describe "when the condition is registred" do
    it "is valid" do
      expect(subject).to be_valid
    end
  end

  describe "when the condition is not registred" do
    subject { described_class.new(organization:, name: "unknown_dummy_condition", settings: {}, condition_type: "unknown_dummy_condition") }

    it "is invalid" do
      expect(subject).to be_invalid
    end
  end

  it "is invalid if the name is not present" do
    subject = described_class.new(organization:, name: nil, settings: {}, condition_type: "dummy")
    expect(subject).to be_invalid
  end

  it "is invalid if the condition_type is not present" do
    subject = described_class.new(organization:, name: "dummy", settings: {}, condition_type: nil)
    expect(subject).to be_invalid
  end

  it "is invalid if the no organization is provided" do
    subject = described_class.new(organization: nil, name: "dummy", settings: {}, condition_type: "dummy")
    expect(subject).to be_invalid
  end
end
