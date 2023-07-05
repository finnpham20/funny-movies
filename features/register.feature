Feature: Login
  As a registered user
  I want to be able to log in
  So that I can access my account

  Scenario: Register new user
    Given I am on the home page
    When I fill in email with "new_user@email.com"
    And I fill in password with "Abc@123456"
    And I click the "Login/Register" button
    Then I should be on the home page
    And I should see the message "Register successful! Please login to continue"

  Scenario: Register new user invalid password
    Given I am on the home page
    When I fill in email with "new_user1@email.com"
    And I fill in password with "Abc123456"
    And I click the "Login/Register" button
    Then I should be on the home page
    And I should see an error message "Password: Your password must be at least 8 characters long, contain at least one number and @ and have a mixture of uppercase and lowercase letters."

  Scenario: Register new user invalid email
    Given I am on the home page
    When I fill in email with "new_user2email.com"
    And I fill in password with "Abc@123456"
    And I click the "Login/Register" button
    Then I should be on the home page
    And I should see an error message "Email: is invalid"
