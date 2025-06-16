class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :client, null: false, foreign_key: true
      t.date :opening_date
      t.string :status

      t.timestamps
    end
  end
end
