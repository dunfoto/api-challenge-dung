class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :match, index: true
      t.references :player, index: true, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end
  end
end
