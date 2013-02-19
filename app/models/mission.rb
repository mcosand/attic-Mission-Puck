class Mission < ActiveRecord::Base
  has_many :logs
  attr_accessible :county, :number, :started, :title
end
