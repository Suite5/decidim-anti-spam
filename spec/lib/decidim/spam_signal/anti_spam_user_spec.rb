# frozen_string_literal: true

require "spec_helper"

describe Decidim::SpamSignal::AntiSpamUser do
  let(:organization) { create(:organization) }
  let(:spam_cop) { create(:user, :admin, locale: organization.default_locale, organization:) }

  describe "#get" do
    it "create a user from USER_BOT_EMAIL" do
      expect do
        ENV["USER_BOT_EMAIL"] = "test@example.org"
        Decidim::SpamSignal::AntiSpamUser.get(organization)
      end.to change(Decidim::User, :count).by(1)
      expect(Decidim::User.last.email).to eq("test@example.org")
    end

    it "unblock the bot user if was blocked" do
      cop = Decidim::SpamSignal::AntiSpamUser.get(organization)
      cop.update(blocked: true)
      expect do
        Decidim::SpamSignal::AntiSpamUser.get(organization)
      end.to change { cop.reload.blocked? }.from(true).to(false)
    end

    it "set the bot user as admin if he was removed" do
      cop = Decidim::SpamSignal::AntiSpamUser.get(organization)
      cop.update(admin: false)
      expect do
        Decidim::SpamSignal::AntiSpamUser.get(organization)
      end.to change { cop.reload.admin? }.from(false).to(true)
    end
  end
end
