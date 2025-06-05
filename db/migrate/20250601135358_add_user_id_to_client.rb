class AddUserIdToClient < ActiveRecord::Migration[8.0]
  def change
    add_reference :clients, :user, foreign_key: true
  end
end
