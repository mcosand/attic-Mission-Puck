class AddBriefingToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :briefing, :text
  end
end
