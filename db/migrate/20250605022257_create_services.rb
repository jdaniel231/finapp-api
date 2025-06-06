class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name
      t.decimal :value

      t.timestamps
    end
  end
end
