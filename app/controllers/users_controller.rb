class UsersController < ApplicationController

  def show
	@user = User.find(params[:id])
	@title = @user.name
  end
  
  def create
	@user = User.new(params[:user])
	if @user.save
		sign_in @user
		flash[:success] = "Welcome to Connect Four on Rails!"
		redirect_to @user
	else
		@title = "Sign up"
		render 'new'
	end
  end
  
  def new
	@user = User.new
	@title = "Sign Up"
  end

end