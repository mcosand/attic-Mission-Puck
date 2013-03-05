class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.text :message, :null => false
      t.datetime :when, :null => false

      t.uuid :mission_id, :null => false
    end
    add_index(:logs, :mission_id)
  end

  def self.down
    drop_table :logs
  end
end
