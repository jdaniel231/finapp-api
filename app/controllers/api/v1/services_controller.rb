class Api::V1::ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @services = Service.all
    render json: @services
  end

  def show
    @service = Service.find(params[:id])
    render json: @service
  end

  def new
    @service = Service.new
    render json: @service
  end

  def create
    @service = Service.new(service_params)
    # @service.user_id = current_user.id
    if @service.save
      render json: @service, status: :created
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @service = Service.find(params[:id])
    render json: @service
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      render json: @service
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    head :no_content
  end

  private
  def service_params
    params.require(:service).permit(:name, :value)
  end
end
