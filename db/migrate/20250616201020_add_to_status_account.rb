class AddToStatusAccount < ActiveRecord::Migration[8.0]
  def change
    add_column :account_pays, :status, :string
  end
end
