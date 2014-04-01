class AddInTransitToConsignments < ActiveRecord::Migration
  def change
    add_column :consignments, :in_transit, :boolean
  end
end
