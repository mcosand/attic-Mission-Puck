class Log < ActiveRecord::Base
  belongs_to :mission
  attr_accessible :message, :when
end
