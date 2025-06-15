class CreateTicketServices < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_services do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
