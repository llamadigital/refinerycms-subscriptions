@refinerycms @subscriptions @subscriptions-create
Feature: Create Subscriptions
  In order to get regular email updates
  I want to create a subscription

  Background:
    Given A Refinery user exists
    And I have no subscriptions
    And I have a page titled "Subscribe" with a custom url "/subscribe"
    And I have a page titled "Thank You" with a custom url "/subscribe/thank_you"

  Scenario: Subscription page
    When I go to the subscription page
    Then I should see "First name *"
    And I should see "Last name *"
    And I should see "Email *"

  Scenario: Create a valid subscription
    When I go to the subscription page
    And I fill in "First name *" with "Philip"
    And I fill in "Last name *" with "Smith"
    And I fill in "Email *" with "phil@refinerycms.com"
    And I press "Send"
    Then I should be on the subscription thank you page
    And I should see "Thank You"
    And I should have 1 subscriptions

  Scenario: Create an invalid subscription
    When I go to the subscription page
    And I press "Send"
    Then I should be on the subscription create page
    And I should see "First name can't be blank"
    And I should not see "Email can't be blank"
    And I should see "Email is invalid"
    And I should not see "Phone can't be blank"
    And I should see "Last name can't be blank"
    And I should have 0 subscriptions
