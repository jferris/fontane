Feature: Authenticate

  As an author, I would like to authenticate myself, so that only authors can
  perform author actions.

  Scenario: Sign in with good credentials
    Given a user exists with an email of "someone@gmail.com" and a password of "test"
    When I go to the sign in page
    And I fill in "E-mail" with "someone@gmail.com"
    And I fill in "Password" with "test"
    And I press "Sign In"
    Then I should see "You have been successfully signed in"
    When I go to the home page
    Then I should see "You are signed in as someone@gmail.com"

  Scenario: Sign in as an unknown user
    When I go to the sign in page
    And I fill in "E-mail" with "stranger@gmail.com"
    And I fill in "Password" with "test"
    And I press "Sign In"
    Then I should see "Invalid e-mail or password."
    And I should not see "Sign Out"

  Scenario: Sign in as an unknown user
    Given a user exists with an email of "someone@gmail.com" and a password of "test"
    When I go to the sign in page
    And I fill in "E-mail" with "someone@gmail.com"
    And I fill in "Password" with "wrong"
    And I press "Sign In"
    Then I should see "Invalid e-mail or password."
    And I should not see "Sign Out"

  Scenario: Sign in and sign out
    When I go to the sign in page
    And I fill in "E-mail" with "someone@gmail.com"
    And I fill in "Password" with "test"
    And I press "Sign In"
    Then I should see "You have been successfully signed in"
    When I follow "Sign Out"
    Then I should see "You have been successfully signed out"
    When I go to the home page
    Then I should not see "You are signed in as"
