class Log < ActiveRecord::Base
  belongs_to :mission
  attr_accessible :message, :when

  validates :message, :presence => true
	validates :when, :presence => true
end
