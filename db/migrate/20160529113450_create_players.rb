class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_id
      t.string :nick_name

      t.timestamps null: false
    end
  end
end
