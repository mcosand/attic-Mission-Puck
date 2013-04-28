Feature: Sign in and out on a mobile device
	In order to register myself on a mission
	As a responder
  On a mobile device
	I want to sign in and out of the mission

	Background:
    Given there is an active mission "Tiger Injured Hiker"
		When I have an iPhone
    When I am on the homepage
		When I follow "Tiger Injured Hiker"
    Then the page should show a mission called "Tiger Injured Hiker"

	@javascript
	Scenario: Sign in spontaneous responder
    When I enter "George Darwin" in the responder box
    When I follow "George Darwin"
    Then the page should say "New Status:"
    When I pick "Signed In" for "New Status:"
    When I pick "Field" for "Mission Role:"
    When I follow "Sign In"
    Then the page should say "Mission Information:"
    Then the roster should show 1 responders (1 active)
    When I take a screenshot
    When I follow "Roster"
    When I take a screenshot

#	@javascript
#	Scenario: Empty log message
#		When I submit a log message ""
#		Then the page should report an invalid log message.
