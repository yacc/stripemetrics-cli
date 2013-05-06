Feature: Login command
  In order to get access to stripemetics
  I want to be able to login

  @wip
  Scenario: 
    Given that the app is not authorized
    When I run `stripemetrics-cli login` interactively
    And I type "yacin@me.com"
    And I type "sekkret"
    Then I the app should log me in        
