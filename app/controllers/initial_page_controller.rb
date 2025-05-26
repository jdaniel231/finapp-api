class InitialPageController < ApplicationController
  def index
    render json: { message: "Welcome to the Finapp API!" }
  end
end
