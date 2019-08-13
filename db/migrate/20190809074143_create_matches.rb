class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.datetime :match_time
      t.string :venue
      t.string :score
      t.string :match_code
      t.references :group, index: true

      t.timestamps
    end
  end
end
