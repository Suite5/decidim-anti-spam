# frozen_string_literal: true

require "spec_helper"
describe Decidim::SpamSignal::ManifestRegistry::SpamManifest do
  subject do
    described_class.new(
      "dummy",
      Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
      Decidim::SpamSignal::Conditions::DummyConditionCommand
    )
  end

  it "has a name as a symbol" do
    expect(subject.name).to eq(:dummy)
  end

  it "raises an error if the form class does not inherit from Decidim::Form" do
    expect do
      described_class.new(
        "dummy",
        "dummyForm",
        Decidim::SpamSignal::Conditions::DummyConditionCommand
      )
    end.to raise_error(Decidim::SpamSignal::Error)
  end

  it "raises an error if the command class does not inherit from Decidim::Command" do
    expect do
      described_class.new(
        "dummy",
        Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
        "dummyCommand"
      )
    end.to raise_error(Decidim::SpamSignal::Error)
  end
end
