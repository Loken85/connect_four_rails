class AddCurrentplayerToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :current_player, :integer
  end

  def self.down
    remove_column :games, :current_player
  end
end
