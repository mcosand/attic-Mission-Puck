class Unit < ActiveRecord::Base
  include ActiveUUID::UUID

  belongs_to :mission

#  has_many :roster_timelines
  has_many :responders, :through => :roster_timelines

  attr_accessible :longname, :name
end
