class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to :player
      t.integer :total_word
      t.integer :correct_word
      t.integer :wrong_guess
      t.integer :grade
      t.timestamps null: false
    end
  end
end
