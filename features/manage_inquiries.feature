@refinerycms @subscriptions @subscriptions-manage
Feature: Manage Subscriptions
  In order to see subscriptions left for me on my website
  As an Administrator
  I want to manage subscriptions

  Background:
    Given I am a logged in refinery user
    And I have no subscriptions
    And I have an subscription from "David Jones" with email "dave@refinerycms.com" and message "Hello, I really like your website.  Was it hard to build and maintain or could anyone do it?"

  Scenario: Subscriptions List
    When I go to the list of subscriptions
    Then I should see "David Jones said Hello, I really like your website. Was it hard to build ..."
    And I should have 1 subscriptions
    And I should not see "Add"

  Scenario: Spam List
    When I go to the list of subscriptions
    And I follow "Spam"
    Then I should see "Hooray! You don't have any spam."

  @subscription-settings
  Scenario: Updating who gets notified
    When I go to the list of subscriptions
    And I follow "Update who gets notified"
    And I fill in "Send notifications to" with "phil@refinerycms.com"
    And I press "Save"
    Then I should be redirected back to "the list of subscriptions"
    And I should see "'Notification Recipients' was successfully updated."
    And I should be on the list of subscriptions

  @subscription-settings
  Scenario: Updating confirmation email copy
    When I go to the list of subscriptions
    And I follow "Edit confirmation email"
    And I fill in "Message" with "Thanks %name%! We'll never get back to you!"
    And I press "Save"
    Then I should be redirected back to "the list of subscriptions"
    And I should see "'Confirmation Body' was successfully updated."
    And I should be on the list of subscriptions

  Scenario: Subscriptions Show
    When I go to the list of subscriptions
    And I follow "Read the subscription"
    Then I should see "From David Jones [dave@refinerycms.com]"
    And I should see "Hello, I really like your website. Was it hard to build and maintain or could anyone do it?"
    And I should see "Age"
    And I should see "Back to all Subscriptions"
    And I should see "Remove this subscription forever"

  Scenario: Subscriptions Delete
    When I go to the list of subscriptions
    And I follow "Read the subscription"
    And I follow "Remove this subscription forever"
    Then I should see "'David Jones' was successfully removed."
    And I should have 0 subscriptions
