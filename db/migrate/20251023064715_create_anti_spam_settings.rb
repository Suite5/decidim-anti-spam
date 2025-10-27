# frozen_string_literal: true

class CreateAntiSpamSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :anti_spam_settings do |t|
      t.string :anti_spam_mode
      t.belongs_to :decidim_organization, foreign_key: true

      t.timestamps
    end
  end
end
