# frozen_string_literal: true

class CreateAntiSpamConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :anti_spam_conditions do |t|
      t.string :condition_type
      t.string :name
      t.references :decidim_organization, foreign_key: true, index: true
      # Each condition defines a forms that needs to validate
      # before saving settings
      t.jsonb :settings

      t.timestamps
    end
  end
end
