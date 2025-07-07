class Api::V1::RedeCardTransactionsController < ApplicationController
  # skip_before_action :verify_authenticity_token, if: -> { respond_to?(:verify_authenticity_token) }
  skip_before_action :authenticate_user!, only: [ :create ]

  def index
    render json: RedeCardTransaction.all
  end

  def create
    transaction_data = params.require(:rede_card_transaction).permit!
    RedeCardTransactionService.process(transaction_data)
    head :ok
  end
end
