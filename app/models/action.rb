class Action < ActiveRecord::Base
  include ActiveUUID::UUID

  attr_accessible :reference, :data, :source, :when

  validates :data, :presence => true
  validates :reference, :presence => true
  validates :when, :presence => true

  def perform
    raise "Can't execute perform on generic Action"
  end
end
