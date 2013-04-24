class Mission < ActiveRecord::Base
  include ActiveUUID::UUID

  has_many :logs
  has_many :units
  has_many :responders
  has_many :teams

  attr_accessible :county, :number, :started, :title, :briefing

	validates :title, :presence => true
	validates :started, :presence => true
end
