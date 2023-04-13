@api @files_sharing-app-required
Feature: sharees

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | sharee1  |
    And group "ShareeGroup" has been created
    And group "ShareeGroup2" has been created
    And user "Alice" has been added to group "ShareeGroup2"

  @smokeTest
  Scenario Outline: Search without exact match
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | sharee |
      | itemType | file   |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be
      | ShareeGroup  | 1 | ShareeGroup  |
      | ShareeGroup2 | 1 | ShareeGroup2 |
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search without exact match not-exact casing
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | sHaRee |
      | itemType | file   |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be
      | ShareeGroup  | 1 | ShareeGroup  |
      | ShareeGroup2 | 1 | ShareeGroup2 |
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |

  @skipOnLDAP
  Scenario Outline: Search only with group members - allowed
    Given using OCS API version "<ocs-api-version>"
    And parameter "shareapi_only_share_with_group_members" of app "core" has been set to "yes"
    And user "Sharee1" has been added to group "ShareeGroup2"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | sharee |
      | itemType | file   |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be
      | ShareeGroup  | 1 | ShareeGroup  |
      | ShareeGroup2 | 1 | ShareeGroup2 |
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search with exact match
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | Sharee1 |
      | itemType | file    |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search with exact match not-exact casing
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | sharee1 |
      | itemType | file    |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search with exact match not-exact casing group
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | shareegroup2 |
      | itemType | file         |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be
      | ShareeGroup2 | 1 | ShareeGroup2 |
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search with "self"
    Given using OCS API version "<ocs-api-version>"
    When user "Sharee1" gets the sharees using the sharing API with parameters
      | search   | Sharee1 |
      | itemType | file    |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be
      | Sharee One | 0 | sharee1 |
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Federated sharee for files
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | test@localhost |
      | itemType | file           |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be
      | test@localhost | 6 | test@localhost |
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Federated sharee for calendars not allowed
    Given using OCS API version "<ocs-api-version>"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | test@localhost |
      | itemType | calendar       |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be empty
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |

  @skipOnLDAP
  Scenario Outline: Enumerate only group members - only show partial results from member of groups
    Given using OCS API version "<ocs-api-version>"
    And these users have been created with default attributes and without skeleton files:
      | username | displayname |
      | another  | Another     |
    And user "Another" has been added to group "ShareeGroup2"
    And parameter "shareapi_share_dialog_user_enumeration_group_members" of app "core" has been set to "yes"
    When user "Alice" gets the sharees using the sharing API with parameters
      | search   | anot |
      | itemType | file |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be
      | Another | 0 | another |
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be empty
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |


  Scenario Outline: Search without exact match such that the search string matches the user getting the sharees
    Given user "sharee2" has been created with default attributes and without skeleton files
    And using OCS API version "<ocs-api-version>"
    When user "sharee1" gets the sharees using the sharing API with parameters
      | search   | sharee |
      | itemType | file   |
    Then the OCS status code should be "<ocs-status>"
    And the HTTP status code should be "<http-status>"
    And the "exact users" sharees returned should be empty
    And the "users" sharees returned should be
      | Sharee One | 0 | sharee1 |
      | Sharee Two | 0 | sharee2 |
    And the "exact groups" sharees returned should be empty
    And the "groups" sharees returned should be
      | ShareeGroup  | 1 | ShareeGroup  |
      | ShareeGroup2 | 1 | ShareeGroup2 |
    And the "exact remotes" sharees returned should be empty
    And the "remotes" sharees returned should be empty
    Examples:
      | ocs-api-version | ocs-status | http-status |
      | 1               | 100        | 200         |
      | 2               | 200        | 200         |