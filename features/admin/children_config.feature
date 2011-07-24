Feature: Children config
  Scenario: With a children_config part
    Given I am logged in as "existing"
    And there is a homepage
    When I edit the "home" page
    And I press "Foo"
    Then I should see "boo"