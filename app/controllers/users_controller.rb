class UsersController < ApplicationController

  skip_before_action :authenticate

  def index
      @user = User.find(session[:user]["id"])
      @recipes = @user.recipes.order(created_at: :asc)
  end
  def show
      @recipe = Recipe.find(params[:id])
  end
  def sign_up
  end
  def sign_up!
    @user = User.new(
      username: params[:username],
      useremail: params[:useremail],
      password_digest: BCrypt::Password.create(params[:password])
    )
    if params[:password_confirmation] != params[:password]
      message = "Your passwords don't match!"
    elsif params[:password_confirmation] == params[:password]
      @user.save
      message = "Your account has been created!"
    else
      message = "Your account couldn't be created. Did you enter a unique username and password?"
    end
    cookies[:username] = {
      value: @user.username,
      expires: 3.years.from_now
    }
    session[:user] = @user
    flash[:notice] = message
    redirect_to recipes_path
  end
  def sign_in
  end
  def sign_in!
    @user = User.find_by(username: params[:username])
    if !@user
      message = "This user doesn't exist!"
    elsif !BCrypt::Password.new(@user.password_digest).is_password?(params[:password])  # need to better understand this line
      message = "Your password's wrong!"
    else
      message = "You're signed in, #{@user.username}!"
      cookies[:username] = {
        value: @user.username,
        expires: 3.years.from_now
      }
      session[:user] = @user
    end
    flash[:notice] = message
    redirect_to recipes_path
  end
   def sign_out
     reset_session
     flash[:notice] = "Signed out, happy cooking!!!"
     redirect_to root_url
   end
end
