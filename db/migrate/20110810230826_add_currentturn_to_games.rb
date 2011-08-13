class AddCurrentturnToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :current_turn, :integer, :default => 1
  end

  def self.down
    remove_column :games, :current_turn
  end
end
