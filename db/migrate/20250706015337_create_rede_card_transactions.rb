class CreateRedeCardTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :rede_card_transactions do |t|
      t.string :tid
      t.string :nsu
      t.string :authorization_code
      t.string :response_code
      t.string :response_message
      t.decimal :amount
      t.integer :installments
      t.string :card_brand

      t.timestamps
    end
  end
end
