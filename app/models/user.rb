class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :services
  has_many :statuses
end
