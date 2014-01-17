class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :customer_tla
      t.text :customer_name

      t.timestamps
    end
  end
end
