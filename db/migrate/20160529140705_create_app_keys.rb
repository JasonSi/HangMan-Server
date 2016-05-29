class CreateAppKeys < ActiveRecord::Migration
  def change
    create_table :app_keys do |t|
      t.string :key
      t.string :title

      t.timestamps null: false
    end
  end
end
