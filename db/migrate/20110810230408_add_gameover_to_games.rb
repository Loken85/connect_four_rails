class AddGameoverToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :game_over, :boolean, :default => false
  end

  def self.down
    remove_column :games, :game_over
  end
end
