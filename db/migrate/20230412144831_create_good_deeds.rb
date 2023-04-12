# frozen_string_literal: true

# db/migrate/20230412144831_create_good_deeds.rb
class CreateGoodDeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :good_deeds do |t|
      t.string :name
      t.integer :host_id
      t.date :date
      t.time :time
      t.string :notes
      t.string :media_link
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
