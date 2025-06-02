class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = Client.all
    render json: @clients
  end

  def show
    @client = Client.find(params[:id])
    render json: @client
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id
    if @client.save
      render json: @client, status: :created
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      render json: @client
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :document_number) # ajuste os campos conforme seu modelo
  end
end
