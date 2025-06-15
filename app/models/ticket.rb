class Ticket < ApplicationRecord
  belongs_to :client
  has_many :ticket_services, dependent: :destroy

  accepts_nested_attributes_for :ticket_services, allow_destroy: true

  before_save :calculate_total_value

  def calculate_total_value
    self.total_value = ticket_services.map(&:value).compact.sum
  end
end
