class CreateAccountPays < ActiveRecord::Migration[8.0]
  def change
    create_table :account_pays do |t|
      t.string :title
      t.string :transaction_type
      t.date :due_date
      t.decimal :value

      t.timestamps
    end
  end
end
