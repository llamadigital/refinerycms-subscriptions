require 'factory_girl'

Factory.define :subscription do |i|
  i.given_name "Refinery"
  i.family_name "Refinery"
  i.email "refinery@cms.com"
end
