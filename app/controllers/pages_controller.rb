class PagesController < ApplicationController

  def home
	@title = "Home"	
	if signed_in?
	@game = current_user.game
	end
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
