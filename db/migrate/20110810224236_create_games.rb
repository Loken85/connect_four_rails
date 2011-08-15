class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :player1_id
      t.string :player1_name
      t.integer :player2_id
      t.string :player2_name
	

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
