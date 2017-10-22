class SessionsController < ApplicationController

  def new
  end

  def create
    user_params = params.require(:user)
    @user = User.where('(username = :username OR email = :username)', username: user_params[:username]).first

    if @user and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to root_path, success: "Connecté"
    else
      redirect_to new_session_path, error: "Identifiants incorrects"
    end
  end

  def forgot
    user_params = params.require(:user)
    if user_params[:username] and user_params[:secret]
      username, secret = user_params[:username], user_params[:secret]
      user = User.where(username: username, secret: secret)
      if user
        redirect_to forgot_success_path
      end
    end
  end

  def logout
    session.destroy
    redirect_to root_path, success: "Vous êtes maintenant déconnecter"
  end
end
