class Mission < ActiveRecord::Base
  has_many :logs
  attr_accessible :county, :number, :started, :title

	validates :title, :presence => true
	validates :started, :presence => true
end
