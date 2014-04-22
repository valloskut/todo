class HomeController < ApplicationController
  def index
    flash[:notice] = 'Home Controller'
  end
end
