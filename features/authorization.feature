Feature: StripeMetrics is not authorized
  In order to use StripeMetrics
  I need to be authorized unless I'm asking for help or login in
  Background:
    Given that the app is not authorized
 
  Scenario Outline: App tells me to login
    When I run `<command>`
    Then the exit status should be 1
    And the output should contain:
    """
    You need to authorize with StripeMetrics.com ! Try login in first with this command:
    stripemetrics-cli login
    """

    Examples:
    | command |
    | stripemetrics-cli import     |
    | stripemetrics-cli import -f customer_deleted.csv |
    | stripemetrics-cli refresh    |
    | stripemetrics-cli report     |

 
  Scenario Outline: App displays help
    When I run `<command>`
    Then the exit status should be 0

    Examples:
    | command |
    | stripemetrics-cli help     |
    | stripemetrics-cli help import     |
    | stripemetrics-cli help refresh    |
    | stripemetrics-cli help report     |  

  Scenario: App logs me in
    When I run `stripemetrics-cli login` interactively
    And I type "yacin@me.com"
    And I type "sekkret"
    Then the exit status should be 0  