@api @issue-1284
Feature: UNLOCK locked items (sharing)

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | Brian    |
    And user "Alice" has created folder "PARENT"
    And user "Alice" has uploaded file "filesForUpload/textfile.txt" to "PARENT/parent.txt"


  Scenario Outline: as share receiver unlocking a shared file locked by the file owner is not possible. To unlock use the owners locktoken
    Given using <dav-path> DAV path
    And user "Alice" has locked file "PARENT/parent.txt" setting the following properties
      | lockscope | <lock-scope> |
    And user "Alice" has shared file "PARENT/parent.txt" with user "Brian"
    And user "Brian" has accepted share "<pending_share_path>" offered by user "Alice"
    When user "Brian" unlocks file "Shares/parent.txt" with the last created lock of file "PARENT/parent.txt" of user "Alice" using the WebDAV API
    Then the HTTP status code should be "403"
    And 1 locks should be reported for file "PARENT/parent.txt" of user "Alice" by the WebDAV API
    And 1 locks should be reported for file "Shares/parent.txt" of user "Brian" by the WebDAV API
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | old      | shared     | /parent.txt        |
      | old      | exclusive  | /parent.txt        |
      | new      | shared     | /parent.txt        |
      | new      | exclusive  | /parent.txt        |

    @personalSpace 
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | spaces   | shared     | /parent.txt        |
      | spaces   | exclusive  | /parent.txt        |


  Scenario Outline: as share receiver unlocking a file in a share locked by the file owner is not possible. To unlock use the owners locktoken
    Given using <dav-path> DAV path
    And user "Alice" has locked file "PARENT/parent.txt" setting the following properties
      | lockscope | <lock-scope> |
    And user "Alice" has shared folder "PARENT" with user "Brian"
    And user "Brian" has accepted share "/PARENT" offered by user "Alice"
    When user "Brian" unlocks file "Shares/PARENT/parent.txt" with the last created lock of file "PARENT/parent.txt" of user "Alice" using the WebDAV API
    Then the HTTP status code should be "403"
    And 1 locks should be reported for file "PARENT/parent.txt" of user "Alice" by the WebDAV API
    And 1 locks should be reported for file "Shares/PARENT/parent.txt" of user "Brian" by the WebDAV API
    Examples:
      | dav-path | lock-scope |
      | old      | shared     |
      | old      | exclusive  |
      | new      | shared     |
      | new      | exclusive  |

    @personalSpace 
    Examples:
      | dav-path | lock-scope |
      | spaces   | shared     |
      | spaces   | exclusive  |


  Scenario Outline: as share receiver unlock a shared file
    Given using <dav-path> DAV path
    And user "Alice" has shared file "PARENT/parent.txt" with user "Brian"
    And user "Brian" has accepted share "<pending_share_path>" offered by user "Alice"
    And user "Brian" has locked file "Shares/parent.txt" setting the following properties
      | lockscope | <lock-scope> |
    When user "Brian" unlocks the last created lock of file "Shares/parent.txt" using the WebDAV API
    Then the HTTP status code should be "204"
    And 0 locks should be reported for file "PARENT/parent.txt" of user "Alice" by the WebDAV API
    And 0 locks should be reported for file "Shares/parent.txt" of user "Brian" by the WebDAV API
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | old      | shared     | /parent.txt        |
      | old      | exclusive  | /parent.txt        |
      | new      | shared     | /parent.txt        |
      | new      | exclusive  | /parent.txt        |

    @personalSpace 
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | spaces   | shared     | /parent.txt        |
      | spaces   | exclusive  | /parent.txt        |


  Scenario Outline: as owner unlocking a shared file locked by the receiver is not possible. To unlock use the receivers locktoken
    Given using <dav-path> DAV path
    And user "Alice" has shared file "PARENT/parent.txt" with user "Brian"
    And user "Brian" has accepted share "<pending_share_path>" offered by user "Alice"
    And user "Brian" has locked file "Shares/parent.txt" setting the following properties
      | lockscope | <lock-scope> |
    When user "Alice" unlocks file "PARENT/parent.txt" with the last created lock of file "Shares/parent.txt" of user "Brian" using the WebDAV API
    Then the HTTP status code should be "403"
    And 1 locks should be reported for file "PARENT/parent.txt" of user "Alice" by the WebDAV API
    And 1 locks should be reported for file "Shares/parent.txt" of user "Brian" by the WebDAV API
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | old      | shared     | /parent.txt        |
      | old      | exclusive  | /parent.txt        |
      | new      | shared     | /parent.txt        |
      | new      | exclusive  | /parent.txt        |

    @personalSpace 
    Examples:
      | dav-path | lock-scope | pending_share_path |
      | spaces   | shared     | /parent.txt        |
      | spaces   | exclusive  | /parent.txt        |


  Scenario Outline: as owner unlocking a file in a share that was locked by the share receiver is not possible. To unlock use the receivers locktoken
    Given using <dav-path> DAV path
    And user "Alice" has shared folder "PARENT" with user "Brian"
    And user "Brian" has accepted share "/PARENT" offered by user "Alice"
    And user "Brian" has locked file "Shares/PARENT/parent.txt" setting the following properties
      | lockscope | <lock-scope> |
    When user "Alice" unlocks file "PARENT/parent.txt" with the last created lock of file "Shares/PARENT/parent.txt" of user "Brian" using the WebDAV API
    Then the HTTP status code should be "403"
    And 1 locks should be reported for file "PARENT/parent.txt" of user "Alice" by the WebDAV API
    And 1 locks should be reported for file "Shares/PARENT/parent.txt" of user "Brian" by the WebDAV API
    Examples:
      | dav-path | lock-scope |
      | old      | shared     |
      | old      | exclusive  |
      | new      | shared     |
      | new      | exclusive  |

    @personalSpace 
    Examples:
      | dav-path | lock-scope |
      | spaces   | shared     |
      | spaces   | exclusive  |