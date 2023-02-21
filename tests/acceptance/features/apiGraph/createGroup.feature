@api @skipOnOcV10 @S935c0615
Feature: create group
  Only user with admin permissions can create new groups

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And the administrator has given "Alice" the role "Admin" using the settings api


  @Tbb37e3d0
  Scenario Outline: admin user creates a group
    When user "Alice" creates a group "<groupname>" using the Graph API
    Then the HTTP status code should be "200"
    And group "<groupname>" should exist
    Examples:
    | groupname       |
    | simplegroup     |
    | España§àôœ€     |
    | नेपाली            |
    | $x<=>[y*z^2+1]! |
    | 😅 😆           |
    | comma,grp1      |
    | Finance (NP)    |
    | slash\Middle    |


  @Tf6b7d6aa
  Scenario: admin user tries to create a group that already exists
    Given group "mygroup" has been created
    When user "Alice" tries to create a group "mygroup" using the Graph API
    And the HTTP status code should be "400"
    And group "mygroup" should exist


  @Te7a956e8
  Scenario: normal user tries to create a group
    Given user "Brian" has been created with default attributes and without skeleton files
    When user "Brian" tries to create a group "mygroup" using the Graph API
    And the HTTP status code should be "401"
    And group "mygroup" should not exist


  @T7b65c19d
  Scenario: admin user tries to create a group that is the empty string
    When user "Alice" tries to create a group "" using the Graph API
    Then the HTTP status code should be "400"