class TicketService < ApplicationRecord
  belongs_to :ticket

  after_save :update_ticket_total_value
  after_commit :update_ticket_total_value, on: :destroy

  private

  def update_ticket_total_value
    return unless ticket
    ticket.reload
    ticket.calculate_total_value
    ticket.save!
  end
end
