class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.uuid :mission_id, :null => false
      t.uuid :current_id
      t.uuid :member_id

      t.string :firstname
      t.string :lastname
      t.string :number
    end
#    add_index(:responders, :mission_id)
  end
end
