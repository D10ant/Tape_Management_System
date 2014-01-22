class EditTapes < ActiveRecord::Migration
  def change
  	change_table :tapes do |t|
  		t.rename :tape_ref, :reference
  	end
  end
end
