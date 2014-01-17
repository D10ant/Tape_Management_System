class CreateTapes < ActiveRecord::Migration
  def change
    create_table :tapes do |t|
      t.text :tape_ref
      t.integer :customer_id

      t.timestamps
    end
  end
end
