class AddBoardToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :game_board, :string
    add_column :games, :rows, :integer
    add_column :games, :columns, :integer
    add_column :games, :to_win, :integer
  end

  def self.down
    remove_column :games, :to_win
    remove_column :games, :columns
    remove_column :games, :rows
    remove_column :games, :game_board
  end
end
