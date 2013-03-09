Feature: Manage mission basics
	In order to have a mission to track
	As a base support member
  On a mobile device
	I want to create, edit, and delete missions

	Background:
		Given I am on the homepage as mobile

	@javascript
	Scenario: Create Mission
		When I follow "Start New Mission"
    And I fill out the new mission form with title "This is a new mission"
		Then the page should show a mission called "This is a new mission"

#	@javascript
#	Scenario: Empty log message
#		When I submit a log message ""
#		Then the page should report an invalid log message.
