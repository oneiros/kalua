Feature: Register a new user
  In order to sign up with the service
  As a new user
  I want to fill out the registration and confirm it

  Scenario: Show register link on homepage
    Given I am not authenticated
    When I go to the homepage
    Then I should see "Register"

  Scenario: Fill out registration form 
    Given I am not authenticated
      And there are no users
      And I am on the homepage
    When I follow "Register"
      And I fill in "user_email" with "hans.meiser@example.org"
      And I fill in "user_password" with "test123"
      And I fill in "user_password_confirmation" with "test123"
      And I press "Sign up"
    Then I should see "Sign in"
      And there should be 1 user
      And the user should have a preference
      And the user should have a calendar
      And the user should have 1 calendar

