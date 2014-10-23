class AddDeletedByToTapes < ActiveRecord::Migration
  def change
    add_column :tapes, :deleted_by, :string
  end
end
