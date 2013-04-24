require 'classy_enum'

class RosterTimeline < ActiveRecord::Base
  include ActiveUUID::UUID

  belongs_to :responder
  belongs_to :unit

  classy_enum_attr :status, :enum => 'ResponderStatus', :default => 'unknown'
  classy_enum_attr :role, :enum => 'ResponderRole', :default => 'field'

  attr_accessible :miles, :time

  def self.assignable_attributes
    accessible_attributes.to_a.concat(['status', 'role'])
  end
end
