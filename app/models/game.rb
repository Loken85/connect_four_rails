class Game < ActiveRecord::Base

	#require './lib/connectfour.rb' old implementation
	
	serialize :game_board

	attr_accessible :player1_id, :player2_id, :current_turn, :game_begun, :game_over, :rows, :columns, :to_win
	
	
	belongs_to :player1, :class_name => "User"
	belongs_to :player2, :class_name => "User"
	
	def make_board(rows, columns, to_win)
		self[:rows] = rows #number of rows on connect 4 board
		self[:columns] = columns #number of columns
		self[:to_win] = to_win #number in a line to win
		@game_board ||= Array.new(columns)
		self[:game_board] = @game_board
		self.save
	end
	
	def start
		@player1 = User.find_by_id(self.player1_id)
		@player2 = User.find_by_id(self.player2_id)
		
		self.make_board(7, 7, 4)
				
		
		self[:current_turn] = 1
		self[:current_player] = self.player1_id
		
		self[:game_begun] = true
			
		self.save
	end
	
	def turn(player, column)
		self.do_move(player, column)
		if self.check_win?(player)
			 self.game_over = true
			 self.save
			 return true
		end
		self.current_turn = self.current_turn + 1
		if self.current_player == self.player2_id
			self.current_player = self.player1_id
		else
			self.current_player = self.player2_id
		end
		self.save
		return nil
	end
	
	def do_move(player, column)
		colmn = get_column(column)
		unless position(max_row, column)
		colmn << Piece.new(player)
		end
	end
	
	# Check if a peice is in a slot
	def position(row, column)
		colmn = get_column(column)
		return colmn[row] unless colmn.nil?
	end
	
	#check if current player
	def is_current_player(user) 
		return user.id == self.current_player
	end
	
	# Reset the board
	def reset
		self.game_board = nil
		self.save
	end
	
	# Check for victory
	def check_win?(player)
		vertical_win?(player) || horizontal_win?(player) || diagonal_win?(player) || other_diagonal_win?(player)
	end
	
	def get_column(col)
		@game_board = self.game_board
		@game_board[col] ||= []
	end
	
	def max_row
		max_row = self.rows-1 #7 rows, index at 6
	end
	
	#vertical win check
	def vertical_win?(player)
		win =false
		self.game_board.each do |column|
			unless column.nil?
				counter = 0
				column.each do |position|
					counter = increment(position, player, counter)
					win ||= win?(counter)
				end
			end
		end
		win
	end
	
	#horizontal win check
	def horizontal_win?(player)
		win = false
		@rows = self.rows
		(0..@rows).each do |row|
			counter  = 0
			self.game_board.each_with_index do |column, column_index|
				counter = 0 if column.nil?
				position = position(row, column_index)
				counter = increment(position, player, counter)
				win ||= win?(counter)
			end
		end
		win
	end
	
	def diagonal_win?(player)
		win = false
		@columns = self.columns
		@to_win = self.to_win
		(0..@columns-@to_win).each do |i|
			counter = 0
			rowlimit = max_row - i
			(0..rowlimit).each do |j|
				position = position(j, i+j)
				counter = increment(position, player, counter)
				win ||= win?(counter)
			end
		end
		win
	end
	
	def other_diagonal_win?(player)
		win = false
		@columns = self.columns
		@to_win = self.to_win
		(@to_win-1...@columns).each do |i|
			counter = 0
			rowlimit = max_row > i ? i : max_row
			(0..rowlimit).each do |j|
				position = position(j, i-j)
				counter = increment(position, player, counter)
				win ||= win?(counter)
			end
		end
		win
	end
	
	def increment(position, player, counter)
		if position && position.player == player
			return counter.next
		else
			return 0
		end
	end
	
	def win?(counter)
		counter >= self.to_win
	end
	
	def display_board # for debugging purposes
		@rows = self.rows
		@game_board = self.game_board
		(0...@rows).each do |row|
			@game_board.each_with_index do |column, index|
				position = position(@rows-row-1, index)
				if position
								
					printf("#{position.player.id}")
				else
					printf(" ")
				end
			end
			printf("\n")
		end
	end
	
end

class Piece
	def initialize(player)
		@player = player
	end
		
	def player
		@player
	end
end
