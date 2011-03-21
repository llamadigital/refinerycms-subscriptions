require 'factory_girl'

Factory.define :subscription do |i|
  i.name "Refinery"
  i.email "refinery@cms.com"
  i.message "Hello..."
end
