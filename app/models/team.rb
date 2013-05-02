class Team < ActiveRecord::Base
  include ActiveUUID::UUID

  belongs_to :mission
  belongs_to :leader, :class_name => 'Responder'

  attr_accessible :name

  has_many :members, :class_name => 'Responder'

  validates :name, :presence => true
  classy_enum_attr :kind, :enum => 'TeamKind', :default => 'field'

  def self.assignable_attributes
    accessible_attributes.to_a.concat(['kind'])
  end

  def self.related_keys
    ['mission_id','leader_id']
  end
end
