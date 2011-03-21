Given /^I have no subscriptions$/ do
  Subscription.delete_all
end

Then /^I should have ([0-9]+) subscriptions?$/ do |count|
  Subscription.count.should == count.to_i
end

Given /^I have an? subscription from "([^"]*)" with email "([^\"]*)" and message "([^\"]*)"$/ do |name, email, message|
  Subscription.create(:name => name,
                 :email => email,
                 :message => message)
end

Given /^I have an? subscription titled "([^"]*)"$/ do |title|
  Subscription.create(:name => title,
                 :email => 'test@cukes.com',
                 :message => 'cuking ...',
                 :spam => false)

  Subscription.create(:name => title,
                 :email => 'test@cukes.com',
                 :message => 'cuking ...',
                 :spam => true)
end
