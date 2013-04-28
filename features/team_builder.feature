Feature: Manage teams and team membership
	In order to keep track of mission resources
	As a search planner
  On a mobile device
	I want to drag people onto teams

	Background:
    Given there is an active mission "Granite Mountain Avalanche"
    When I am on the homepage
    Given I am on a desktop
    Then the page should show a mission called "Granite Mountain Avalanche"

	@javascript
	Scenario: Create team by dragging
    Given there is a responder "Matthew Fox"
    Given there is a responder "Peter Haynes"
    Given there is a responder "Matthew Lockwood"
    When I follow "Teams"
    Then the page should say "Staging"
    Then "Catherine Hoxie -- signedin" should be in staging
    When I drag responder "Catherine Hoxie -- signedin" to team "Bravo"
    Then "Catherine Hoxie -- assigned" should be on team "Bravo"

