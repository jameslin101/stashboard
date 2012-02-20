class Service < ActiveRecord::Base
  belongs_to :user
  has_many :statuses, :order=> "time DESC"
  attr_accessible :name, :desc
  
  validates_presence_of :name
  #validates_presence_of :user_id
  
  def is_admin? (user)
    return user == self.user
  end

end
