Feature: Register
  Scenario: register successful
    When I go to register page
    And I fill in the following:
      | Login                 | flyerhzm           |
      | Email                 | flyerhzm@gmail.com |
      | Password              | flyerhzm           |
      | Password confirmation | flyerhzm           |
    And I press "Register"
    Then I should be on the user show page for flyerhzm
    And I should see "Register successful!"
