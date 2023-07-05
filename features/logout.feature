Feature: Logout
  As a logged-in user
  I want to be able to logout
  So that I can securely end my session

  Background:
    Given a user
    Given I am logged in as a user

  Scenario: User successfully logs out
    When I click on the "Logout" button
    Then I should be redirected to the home page
    And I should see the message "Logout successful!"

  Scenario: User is already logged out
    When I am on the home page
    Then I should not see the "Logout" button
    And I should not see the message "Logout successful!"
