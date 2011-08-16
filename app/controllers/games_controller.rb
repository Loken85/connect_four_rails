class GamesController < ApplicationController

	def show
		if current_user.game
		@game = current_user.game		
			if !@game.player1_id.nil?	
				@player1 = User.find_by_id(@game.player1_id)
			end
			if !@game.player2_id.nil?	
				@player2 = User.find_by_id(@game.player2_id)
			end
		end		
		#@game = Game.where("id = ?", params[:game_id])
	end
	
	def move
		@game = current_user.game
		@player1 = User.find_by_id(@game.player1_id)
		@player2 = User.find_by_id(@game.player2_id)
		@column = Integer(params[:column])
		@game.turn(current_user, @column)
		@game = current_user.game
		respond_to do |format|
			format.html {redirect_to(:back)}
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
		@game = current_user.game
		@player1 = User.find_by_id(@game.player1_id)
		@player2 = User.find_by_id(@game.player2_id)
		respond_to do |format|
			format.html {redirect_to(:back)}
			format.js
		end
	end
	
	def create #can be removed
		@game = Game.new
		@game.player1_id = current_user.id
		@game.player1_name = current_user.name
		@game.save
		redirect_to current_user	
	end
	
	def new
		@game = Game.new
	end
	
	def join #put in games_helper.rb or remove
		@game = Game.find_by_id(id)	
		@game.player2_id = current_user.id
		@game.player2_name = current_user.name
		
		@game.save
		redirect_to current_user	
	end
	
	def destroy
		@game = current_user.game
		@game.delete
		respond_to do |format|
			format.html {redirect_to(:back)}
			format.js
		end
	end

end
