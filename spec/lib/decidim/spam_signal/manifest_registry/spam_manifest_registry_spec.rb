# frozen_string_literal: true

require "spec_helper"
describe Decidim::SpamSignal::ManifestRegistry::SpamManifestRegistry do
  subject { described_class.new }

  describe "#initialize" do
    it "initializes an empty array of manifests" do
      expect(subject.manifests).to eq([])
    end

    it "raises an error if the manifest is already registered" do
      subject.register(
        "dummy_double",
        Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
        Decidim::SpamSignal::Conditions::DummyConditionCommand
      )
      expect do
        subject.register(
          "dummy_double",
          Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
          Decidim::SpamSignal::Conditions::DummyConditionCommand
        )
      end.to raise_error(Decidim::SpamSignal::Error)
    end
  end

  describe "#unregister" do
    it "unregisters a manifest" do
      subject.register("dummy", Decidim::SpamSignal::Conditions::DummyConditionSettingsForm, Decidim::SpamSignal::Conditions::DummyConditionCommand)
      subject.unregister("dummy")
      expect(subject.manifests).to eq([])
    end
  end

  describe "#form_for" do
    it "returns the form for a manifest" do
      subject.register("dummy", Decidim::SpamSignal::Conditions::DummyConditionSettingsForm, Decidim::SpamSignal::Conditions::DummyConditionCommand)
      expect(subject.form_for("dummy")).to eq(Decidim::SpamSignal::Conditions::DummyConditionSettingsForm)
    end
  end

  describe "#command_for" do
    it "returns the command for a manifest" do
      subject.register("dummy", Decidim::SpamSignal::Conditions::DummyConditionSettingsForm, Decidim::SpamSignal::Conditions::DummyConditionCommand)
      expect(subject.command_for("dummy")).to eq(Decidim::SpamSignal::Conditions::DummyConditionCommand)
    end
  end

  describe "#register" do
    it "registers a manifest" do
      subject.register(
        "dummy",
        Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
        Decidim::SpamSignal::Conditions::DummyConditionCommand
      )
      expect(subject.manifests).to eq([Decidim::SpamSignal::ManifestRegistry::SpamManifest.new(
        "dummy",
        Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
        Decidim::SpamSignal::Conditions::DummyConditionCommand
      )])
    end
  end

  describe "#include?" do
    it "returns true if the manifest is registered" do
      subject.register(
        "dummy",
        Decidim::SpamSignal::Conditions::DummyConditionSettingsForm,
        Decidim::SpamSignal::Conditions::DummyConditionCommand
      )
      expect(subject).to include("dummy")
    end

    it "returns false if the manifest is not registered" do
      expect(subject).not_to include("dummy")
    end
  end
end
