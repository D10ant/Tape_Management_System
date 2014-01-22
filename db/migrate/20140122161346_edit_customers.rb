class EditCustomers < ActiveRecord::Migration
  def change
  	change_table :customers do |t|
  		t.rename :customer_tla, :tla
  		t.rename :customer_name, :name
  	end
  end
end
