class Status < ActiveRecord::Base
  STATETYPES = %w(Up Down Info Problem)
  belongs_to :service
  
  attr_accessible :time, :state, :message
  
  validates_presence_of :time, :state, :message, :service_id
  
  validates_inclusion_of :state, :in => STATETYPES, :message => "Invalid state"
end
