class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :loggedIn, :notAuthorize, :loggedAdmin
  add_flash_types :success, :error

  def loggedIn
    unless current_user
      redirect_to new_session_path, error: 'Vous devez être connecté pour accèder a cette page'
    end
  end

  def admin_only
    if current_user.role != "admin"
      render "/errors/404", layout: "application"
    end
  end

  def loggedAdmin(current)
    return nil if current != 'admin'
  end

  def notAuthorize
    if current_user.nil?
      redirect_to request.referer, error: "Vous n'êtes pas autoriser a effectuer cette action"
    end
  end

  def current_user
    return nil if !session[:auth] || !session[:auth]['id']
    return @_user if @_user
    @_user = User.find_by_id(session[:auth]['id'])
  end
end
