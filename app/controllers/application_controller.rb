class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  private

  def authenticate_user_from_token!
    user_email = request.headers['User-Email'] || params[:user_email].presence
    user = user_email && User.find_by_email(user_email)
    user_token = request.headers['User-Token'] || params[:user_token].presence
    if user && Devise.secure_compare(user.authentication_token, user_token)
      sign_in user, store: false
    end
  end
end
