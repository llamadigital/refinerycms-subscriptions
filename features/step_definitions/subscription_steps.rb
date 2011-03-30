Given /^I have no subscriptions$/ do
  Subscription.delete_all
end

Then /^I should have ([0-9]+) subscriptions?$/ do |count|
  Subscription.count.should == count.to_i
end

Given /^I have a subscription from "([^"]*) ([^"]*)" with email "([^\"]*)"$/ do |given_name, family_name, email|
  Subscription.create(:given_name => name,:family_name => family_name,:email => email)
end

Given /^I have a subscription titled "([^"]*) ([^"]*)"$/ do |given_name, family_name|
  Subscription.create(:given_name => given_name, :family_name => family_name, :email => 'test@cukes.com')
end
