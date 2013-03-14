class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.uuid :mission_id

      t.string :name
      t.string :longname
    end
  end
end
