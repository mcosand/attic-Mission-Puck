class Mission < ActiveRecord::Base
  include ActiveUUID::UUID

  has_many :logs
  has_many :units
  has_many :responders
  has_many :teams

  attr_accessible :county, :number, :started, :title, :briefing

	validates :title, :presence => true
	validates :started, :presence => true

  def create_children(keys)
    keys ||= {}
    base = Team.new({ :name => '_base', :kind => :base,
                      :id => keys['base_id'], :mission_id => self.id},
                    :without_protection => true)
    val = base.save
    keys['base_id'] = base.id.as_json

    staging = Team.new({ :name => '_staging', :kind => :staging,
                         :id => keys['staging_id'], :mission_id => self.id},
                       :without_protection => true)
    val &= staging.save
    keys['staging_id'] = staging.id.as_json

    val
  end
end
