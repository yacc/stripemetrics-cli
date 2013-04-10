Feature: Help for login command
  In order to understand the setup command
  I want to see relevant help on the setup command

  Scenario: 
    Given that the app is not authorized
    When I run `stripemetrics-cli login` interactively
    And I type "yacin@me.com"
    And I type "sekkret"
    Then I should be logged in        
