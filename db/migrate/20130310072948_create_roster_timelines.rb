class CreateRosterTimelines < ActiveRecord::Migration
  def change
    create_table :roster_timelines, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.uuid :responder_id, :null => false
      t.uuid :unit_id, :null => false

      t.string :status
      t.string :role
      t.datetime :time
      t.integer :miles
    end
  end
end
