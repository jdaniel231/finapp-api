class Api::V1::AccountPaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_pay, only: [ :show, :update, :destroy ]

  def index
    @account_pays = AccountPay.all
    render json: @account_pays
  end

  def show
    render json: @account_pay
  end

  def create
    @account_pay = AccountPay.new(account_pay_params)
    @account_pay.user_id = current_user.id
    @account_pay.status = "pending"
    if @account_pay.save
      render json: @account_pay, status: :created
    else
      render json: { errors: @account_pay.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @account_pay.update(account_pay_params)
      render json: @account_pay
    else
      render json: { errors: @account_pay.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @account_pay.destroy
    head :no_content
  end

  def register_payment
    @account_pay = AccountPay.find(params[:id])
    if @account_pay.update(status: "paid")
      render json: @account_pay, status: :ok
    else
      render json: { errors: @account_pay.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def cancel_payment
    @account_pay = AccountPay.find(params[:id])
    if @account_pay.update(status: "pending")
      render json: @account_pay, status: :ok
    else
      render json: { errors: @account_pay.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_account_pay
    @account_pay = AccountPay.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "AccountPay not found" }, status: :not_found
  end

  def account_pay_params
    params.require(:account_pay).permit(:title, :due_date, :value, :transaction_type, :status)
  end
end
