class PagesController < ApplicationController

  def home
	@title = "Home"	
	@game = current_user.game
	if !@game.nil?
	@player1 = User.find_by_id(@game.player1_id)
	@player2 = User.find_by_id(@game.player2_id)
	end
  end

  def contact
	@title = "Contact"
  end
  
  def about
	@title = "About"
  end

end
