class GamesController < ApplicationController

	def show #superfluous
		@game = @user.game
	end
	
	def move
		@game = current_user.game
		@column = Integer(params[:column])
		@game.turn(current_user, @column)
		respond_to do |format|
			format.html {redirect_to current_user}
			format.js
		end		
	end
	
	def play
		if Game.last.nil?
			@game = Game.create(:player1_id => current_user.id, :player1_name => current_user.name) #name setting not working...just remove names columns from games
			@game.save
		else
			if Game.last.player2_id.nil?
				@game = Game.last
				@game.player2_id = current_user.id
				@game.player2_name = current_user.name
				@game.start
				@game.save
			else
				@game = Game.create(:player1_id => current_user.id, :player1_name => current_user.name)
			end
		end
		redirect_to current_user
	end
	
	def create
		@game = Game.new
		@game.player1_id = current_user.id
		@game.player1_name = current_user.name
		@game.save
		redirect_to current_user	
	end
	
	def new
		@game = Game.new
	end
	
	def join #put in games_helper.rb
		@game = Game.find_by_id(id)	
		@game.player2_id = current_user.id
		@game.player2_name = current_user.name
		
		@game.save
		redirect_to current_user	
	end
	
	def destroy
		#Game.find(params[:id]).destroy for final method
		Game.last.delete # for testing
		redirect_to current_user
	end

end
