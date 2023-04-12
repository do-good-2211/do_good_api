class CreateUserGoodDeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :user_good_deeds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :good_deed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
