class Commands::Command < ActiveRecord::Base
  include ActiveUUID::UUID

  attr_accessible :reference, :data, :source, :when

  validates :data, :presence => true
  validates :reference, :presence => true
  validates :when, :presence => true

  attr_accessor :topmost, :is_replay

  def self.make(reference, data)
    self.new({
      :reference => reference,
      :data => data,
      :when => Time.now,
      :source => "@#{`hostname`.strip}"})
  end

  def execute
    val = false

    # If this command is not a nested command then wrap it in a transaction
    if (self.topmost || true) then
      self.transaction do
        val = internal_execute

        # If the operation was successful and this isn't
        # a replay operation, save this command to the database
        if (val && (!is_replay || false)) then
          self.save!
        end
      end
    else
      val = internal_execute
    end
    val
  end

  def internal_execute
    raise "Can't execute perform on generic Command"
  end
end
