class AddDeletedAtToTapes < ActiveRecord::Migration
  def change
    add_column :tapes, :deleted_at, :datetime
    add_index :tapes, :deleted_at
  end
end
