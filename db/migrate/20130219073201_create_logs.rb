class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :message
      t.datetime :when
      t.references :mission

      t.timestamps
    end
    add_index :logs, :mission_id
  end
end
