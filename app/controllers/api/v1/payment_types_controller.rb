class Api::V1::PaymentTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @payment_types = PaymentType.all
    render json: @payment_types
  end

  def new
    @payment_type = PaymentType.new
    render json: @payment_type
  end

  def create
    @payment_type = PaymentType.new(payment_type_params)
    # @payment_type.user_id = current_user.id
    if @payment_type.save
      render json: @payment_type, status: :created
    else
      render json: { errors: @payment_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    set_payment_type
    if @payment_type.update(payment_type_params)
      render json: @payment_type
    else
      render json: { errors: @payment_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @payment_type = PaymentType.find(params[:id])
    render json: @payment_type
  end

  def destroy
    @payment_type = PaymentType.find(params[:id])
    @payment_type.destroy
    head :no_content
  end


  private
  def payment_type_params
    params.require(:payment_type).permit(:name, :taxa) # ajuste os campos conforme seu modelo
  end
  def set_payment_type
    @payment_type = PaymentType.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Payment type not found" }, status: :not_found
  end
end
