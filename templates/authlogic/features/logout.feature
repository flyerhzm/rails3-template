Feature: Logout
  Scenario: logout successful
    Given a user_flyerhzm exists
    When I go to login page
    And I fill in "Login" with "flyerhzm"
    And I fill in "Password" with "flyerhzm"
    And I press "Login"
    Then I should be on the home page
    And I should see "Login successful!"
    When I follow "Logout"
    Then I should see "Logout successful!"
    And I should see "Login"
