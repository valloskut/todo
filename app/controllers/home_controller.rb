class HomeController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  def api
  end

end
