Feature: Login
  As a registered user
  I want to be able to log in
  So that I can access my account

  Background: Register new account before login
    Given a user

  Scenario: Successful login
    Given I am on the home page
    When I fill in email with user email
    And I fill in password with "Abc@123456"
    And I click the "Login/Register" button
    Then I should be on the home page
    And I should see text welcome my email

  Scenario: Failed login
    Given I am on the home page
    When I fill in email with user email
    And I fill in password with "wrong_password"
    And I click the "Login/Register" button
    Then I should see an error message "Email or Password incorrect!"
