class UsersController < ApplicationController

  before_action :loggedIn, only: [:account, :edit, :update]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      redirect_to new_session_path, success: "Votre compte a bien été créer"
    else
      render :new
    end
  end


  def account
    @like = Like.where(user_id: current_user)
  end

  def edit
    loggedIn
    @user = current_user
  end

  def update
    @user = current_user

    user_params = params.require(:user).permit(:email, :firstname, :lastname, :secret)

    if @user.update(user_params)
      redirect_to profil_path, success: "Votre compte a bien été mis à jour"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
