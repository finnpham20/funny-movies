Feature: Create Post
  As a logged-in user
  I want to be able to create a post
  So that I can share my thoughts with others

  Background:
    Given a user
    Given I am logged in as a user

  Scenario: User creates a post successfully
    When I visit the new post page
    And I fill in "post[youtube_url]" with "https://www.youtube.com/watch?v=t0Q2otsqC4I"
    And I click on the "Share" button
    Then I should be redirected to the home page
    And I should see the message "Your URL is added to share, please wait a moment to see your movie on newsfeed!"

  Scenario: User creates a post with youtube url incorrectly
    When I visit the new post page
    And I fill in "post[youtube_url]" with "https://www.yout.ube.com/watch?v=t0Q2otsqC4I"
    And I click on the "Share" button
    Then I should be redirected to the home page
    And I should see an error message "Youtube Url: is not in the correct format."
    
