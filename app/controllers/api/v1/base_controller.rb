class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  rescue_from Exception, with: :render_error

  protected

  def render_error(exception)
    render json: {error: exception.to_s}, status: :bad_request
  end
end
