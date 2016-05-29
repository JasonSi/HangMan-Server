class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :uid
      t.string :nick_name

      t.timestamps null: false
    end
  end
end
