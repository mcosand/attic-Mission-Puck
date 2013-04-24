class Responder < ActiveRecord::Base
  include ActiveUUID::UUID

  belongs_to :mission
#  belongs_to :member

  attr_accessible :firstname, :lastname, :number

  belongs_to :current, :class_name => 'RosterTimeline'
  belongs_to :team

  has_many :timeline, :class_name => 'RosterTimeline'
end
