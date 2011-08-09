class Game

	attr_accessor :current_turn, :current_player

	def start(player1, player2)
		@player1 = player1
		@player2 = player2
		
		@game_board = ConnectFourGameBoard.new(7,7,4)
		
				
		@board = @game_board.board
		
		#needs to save game to session, so players can call its methods on it
		
		current_turn = 1
		current_player = @player1 #TODO put in ||= assignment to deal with null case
		@game_over = false
			
		
	end
	
	def turn(player, column)
		@game_board.do_move(player, column)
		if @game_board.check_win?(player)
			 return @game_over = true
		end
		increment(current_turn)
		if @current_player == @player1
			@current_player = @player2
		else
			@current_player = @player1
		end
		return nil
	end
	
	def increment(curr)
		curr = curr + 1 #TODO put in ||= assignment to deal with null case
	end
	
	
#If game is started, and if player == current_player then they are shown the active board, where clicking a 
#column will call @game_board.do_move(player, column)
#When do_move causes check_win? to be true, display the final static board for both players, and save stats to score board

end