class Subscription < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:name, :email]

  default_scope :order => 'created_at DESC' # previously scope :newest

  def self.latest(number = 7)
    limit(number)
  end

end

