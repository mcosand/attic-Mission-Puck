class Mission < ActiveRecord::Base
  include ActiveUUID::UUID

  has_many :logs

  attr_accessible :county, :number, :started, :title

	validates :title, :presence => true
	validates :started, :presence => true
end
