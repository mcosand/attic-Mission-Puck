Feature: Mission logging
	In order to keep track of mission progress
	As a base support member
	I want to log events to the database

	Background:
		Given there is an active mission "Test Mission"
		And I am on the homepage
		When I follow "Logs"

	@javascript
	Scenario: Create log message
		When I submit a log message "Log Test Message"
		Then the page should show a log message "Log Test Message"

	@javascript
	Scenario: Empty log message
		When I submit a log message ""
		Then the page should report an invalid log message.
