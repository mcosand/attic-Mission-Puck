Feature: Manage mission basics
  In order to have a mission to track
  As a base support member
  On a mobile device
  I want to create, edit, and delete missions

  Background:
    Given I have an iPhone
    Given I am on the homepage

  @javascript
  Scenario: Create Mission
    When I follow "Start New Mission"
    And I fill out the new mission form with title "Mt Thompson Fallen Climber"
    Then the page should show a mission called "Mt Thompson Fallen Climber"
    When I take a screenshot

#  @javascript
#  Scenario: Empty log message
#    When I submit a log message ""
#    Then the page should report an invalid log message.
