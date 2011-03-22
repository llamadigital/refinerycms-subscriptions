class Subscription < ActiveRecord::Base

  validates :given_name, :presence => true
  validates :family_name, :presence => true
  validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:given_name, :family_name, :email]

  default_scope :order => 'created_at DESC' # previously scope :newest

  def self.latest(number = 7)
    limit(number)
  end

  def fullname
    given_name+' '+family_name
  end

end

