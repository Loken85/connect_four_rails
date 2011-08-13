class UsersController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update, :index, :destroy] #consider making index visible to admin only
   before_filter :correct_user, :only => [:edit, :update]
   before_filter :admin_user, :only => :destroy
	

  def show
	@user = User.find(params[:id])
	@title = @user.name
	@game = @user.game
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
  
  def edit	
	@title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def index
	@title = "Users"
	@users = User.paginate(:page => params[:page])
  end
  
  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User Removed"
	redirect_to users_path
  end
  
  
  
  private

   
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user == @user
    end
	
	def admin_user
		redirect_to(root_path) unless current_user.admin?
	end
  
end
