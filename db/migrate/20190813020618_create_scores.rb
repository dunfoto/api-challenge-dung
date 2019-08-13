class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :match, index: true
      t.integer :player_id
      t.integer :status

      t.timestamps
    end
  end
end
