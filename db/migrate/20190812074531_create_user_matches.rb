class CreateUserMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :user_matches do |t|
      t.references :match, index: true
      t.integer :player1_id
      t.integer :player2_id
      
      t.timestamps
    end
  end
end
