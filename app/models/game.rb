class Game < ActiveRecord::Base

	require './lib/connectfour.rb'

	attr_accessible :player1_id, :player2_id, :current_turn, :game_begun, :game_over
	attr_accessor :game_board
	
	belongs_to :player1, :class_name => "User"
	belongs_to :player2, :class_name => "User"
	
	def start
		@player1 = User.find_by_id(self.player1_id)
		@player2 = User.find_by_id(self.player2_id)
		
		self.game_board = ConnectFourGameBoard.new(7,7,4)
		
				
		game_board.board
		
		
		
		self[:current_turn] = 1
		self[:current_player] = self.player1_id
		
		self[:game_begun] = true
			
		self.save
	end
	
	def turn(player, column)
		self.game_board.do_move(player, column)
		if self.game_board.check_win?(player)
			 return self.game_over = true
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
	
	
end
