Feature: Login
  Scenario: login successful
    Given a user_flyerhzm exists
    When I go to login page
    And I fill in "Login" with "flyerhzm"
    And I fill in "Password" with "flyerhzm"
    And I press "Login"
    Then I should be on the home page
    And I should see "Login successful!"

  Scenario: login failed
    When I go to login page
    And I fill in "Login" with "flyerhzm"
    And I fill in "Password" with "123456"
    And I press "Login"
    Then I should see "is not valid"
