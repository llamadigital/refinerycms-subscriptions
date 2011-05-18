require 'csv'

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
    (given_name || '')+' '+(family_name || '')
  end

  def tags
    self.class.convert_csv_tags(read_attribute(:tags)).map {|tag| tag.strip}
  end

  def tags=(tags)
    if tags.blank?
      write_attribute(:tags,nil)
    else
      write_attribute(:tags,tags.to_csv)
    end
  end

  def self.available_tags
    self.convert_csv_tags(RefinerySetting.find_or_set(:subscription_tags, ""))
  end

  def self.available_tag_options
   self.available_tags.inject('') {|sum, tag| "#{sum}<option value='#{tag}'>#{tag}</option>" }.html_safe
  end

  def self.convert_csv_tags(csv)
    if csv.blank?
      []
    else
      CSV.parse_line(csv)
    end
  end

end

