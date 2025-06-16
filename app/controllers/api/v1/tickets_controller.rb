class Api::V1::TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [ :show, :update, :destroy ]

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def show
    @ticket = Ticket.find(params[:id])
    render json: @ticket.as_json(include: { ticket_services: { only: [ :id, :service_id, :value ] } })
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status = "open"
    @ticket.opening_date = Time.current
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    head :no_content
  end

  # def ticket_services
  #   @ticket = Ticket.find(params[:ticket_id])
  #   @ticket_services = @ticket.ticket_services
  #   render json: @ticket_services
  # rescue ActiveRecord::RecordNotFound
  #   render json: { error: "Ticket not found" }, status: :not_found
  # end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ticket not found" }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(:client_id, :opening_date, :status, :total_value,
                                  ticket_services_attributes: [ :id, :service_id, :value, :_destroy ]
    )
  end
end
