class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.string :document_number

      t.timestamps
    end
  end
end
