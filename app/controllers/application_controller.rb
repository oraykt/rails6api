class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_destroyed error
    render json: error, status: :unprocessable_entity
  end

  def not_found error
    render json: error, status: :not_found
  end
end
