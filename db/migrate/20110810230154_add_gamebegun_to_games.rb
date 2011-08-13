class AddGamebegunToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :game_begun, :boolean, :default => false
  end

  def self.down
    remove_column :games, :game_begun
  end
end
