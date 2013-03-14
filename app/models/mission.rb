class Mission < ActiveRecord::Base
  include ActiveUUID::UUID

  has_many :logs
  has_many :units
  has_many :responders

  attr_accessible :county, :number, :started, :title

	validates :title, :presence => true
	validates :started, :presence => true
end
