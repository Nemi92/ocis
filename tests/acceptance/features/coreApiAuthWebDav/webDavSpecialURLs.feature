@api @skipOnOcV10.10.0 @S75b7cc43
Feature: make webdav request with special urls

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "some data" to "/textfile0.txt"
    And user "Alice" has uploaded file with content "some data" to "/textfile1.txt"
    And user "Alice" has created folder "/PARENT"
    And user "Alice" has created folder "/FOLDER"
    And user "Alice" has uploaded file with content "some data" to "/PARENT/parent.txt"


  @T48536012
  Scenario: send DELETE requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "DELETE" using password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "204"

  @skipOnOcV10 @personalSpace @Ta639e2e0
  Scenario: send DELETE requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "DELETE" using password "%regular%" about user "Alice"
      | endpoint                                             |
      | //remote.php/dav/spaces/%spaceid%/textfile0.txt      |
      | //remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT             |
      | //remote.php/dav//spaces/%spaceid%//FOLDER           |
    Then the HTTP status code of responses on all endpoints should be "204"


  @Teb1ab0be
  Scenario: send GET requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "GET" using password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "200"

  @skipOnOcV10 @personalSpace @Tce604661
  Scenario: send GET requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "GET" using password "%regular%" about user "Alice"
      | endpoint                                             |
      | //remote.php/dav/spaces/%spaceid%/textfile0.txt      |
      | //remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT             |
      | //remote.php/dav//spaces/%spaceid%//FOLDER           |
    Then the HTTP status code of responses on all endpoints should be "200"


  @T1236ab1e
  Scenario: send LOCK requests to webDav endpoints with 2 slashes
    When the user "Alice" requests these endpoints with "LOCK" to get property "d:shared" with password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "200"

  @skipOnOcV10 @personalSpace @Tf9f826f1
  Scenario: send LOCK requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When the user "Alice" requests these endpoints with "LOCK" to get property "d:shared" with password "%regular%" about user "Alice"
      | endpoint                                             |
      | //remote.php/dav/spaces/%spaceid%/textfile0.txt      |
      | //remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT             |
      | //remote.php/dav//spaces/%spaceid%//FOLDER           |
    Then the HTTP status code of responses on all endpoints should be "200"


  @T25ad96e3
  Scenario: send MKCOL requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "MKCOL" using password "%regular%" about user "Alice"
      | endpoint                                   |
      | //remote.php/webdav/PARENT1                |
      | /remote.php//webdav/PARENT2                |
      | //remote.php//webdav/PARENT3               |
      | //remote.php/dav//files/%username%/PARENT4 |
      | /remote.php/dav/files/%username%//PARENT5  |
      | /remote.php/dav//files/%username%/PARENT6  |
    Then the HTTP status code of responses on all endpoints should be "201"

  @skipOnOcV10 @personalSpace @Tb6b2fcff
  Scenario: send MKCOL requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "MKCOL" using password "%regular%" about user "Alice"
      | endpoint                                   |
      | //remote.php/dav/spaces/%spaceid%/PARENT1  |
      | /remote.php//dav/spaces/%spaceid%/PARENT2  |
      | //remote.php//dav/spaces/%spaceid%/PARENT3 |
      | //remote.php/dav//spaces/%spaceid%/PARENT4 |
      | /remote.php/dav/spaces/%spaceid%//PARENT5  |
      | /remote.php/dav//spaces/%spaceid%/PARENT6  |
    Then the HTTP status code of responses on all endpoints should be "201"


  @T3c87a58d
  Scenario: send MOVE requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "MOVE" using password "%regular%" about user "Alice"
      | endpoint                                             | destination                                          |
      | //remote.php/webdav/textfile0.txt                    | /remote.php/webdav/textfileZero.txt                  |
      | /remote.php//dav/files/%username%/textfile1.txt      | /remote.php/dav/files/%username%/textfileOne.txt     |
      | /remote.php/webdav//PARENT                           | /remote.php/webdav/PARENT1                           |
      | //remote.php/dav/files/%username%//PARENT1           | /remote.php/dav/files/%username%/PARENT2             |
      | /remote.php/dav//files/%username%/PARENT2/parent.txt | /remote.php/dav/files/%username%/PARENT2/parent1.txt |
    Then the HTTP status code of responses on all endpoints should be "201"

  @skipOnOcV10 @personalSpace @T11b4c182
  Scenario: send MOVE requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "MOVE" using password "%regular%" about user "Alice"
      | endpoint                                             | destination                                          |
      | /remote.php//dav/spaces/%spaceid%/textfile1.txt      | /remote.php/dav/spaces/%spaceid%/textfileOne.txt     |
      | /remote.php/dav//spaces/%spaceid%/PARENT             | /remote.php/dav/spaces/%spaceid%/PARENT1             |
      | //remote.php/dav/spaces/%spaceid%//PARENT1           | /remote.php/dav/spaces/%spaceid%/PARENT2             |
      | //remote.php/dav/spaces/%spaceid%/PARENT2/parent.txt | /remote.php/dav/spaces/%spaceid%/PARENT2/parent1.txt |
    Then the HTTP status code of responses on all endpoints should be "201"


  @Te0db9c53
  Scenario: send POST requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "POST" including body "doesnotmatter" using password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "500" or "501"

  @skipOnOcV10 @personalSpace @T6f81d7be
  Scenario: send POST requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "POST" including body "doesnotmatter" using password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php//dav/spaces/%spaceid%/textfile1.txt    |
      | /remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT            |
      | //remote.php/dav//spaces/%spaceid%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "500" or "501"


  @T8e84ae89
  Scenario: send PROPFIND requests to webDav endpoints with 2 slashes
    When the user "Alice" requests these endpoints with "PROPFIND" to get property "d:href" with password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER           |
    Then the HTTP status code of responses on all endpoints should be "207"

  @skipOnOcV10 @personalSpace @Te48daa6b
  Scenario: send PROPFIND requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When the user "Alice" requests these endpoints with "PROPFIND" to get property "d:href" with password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php//dav/spaces/%spaceid%/textfile1.txt    |
      | /remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT            |
      | //remote.php/dav//spaces/%spaceid%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "207"


  @T6f1890ee
  Scenario: send PROPPATCH requests to webDav endpoints with 2 slashes
    When the user "Alice" requests these endpoints with "PROPPATCH" to set property "d:getlastmodified" with password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php/webdav/textfile0.txt                   |
      | //remote.php//dav/files/%username%/textfile1.txt    |
      | /remote.php//dav/files/%username%/PARENT/parent.txt |
      | /remote.php//webdav/PARENT                          |
      | //remote.php/dav//files/%username%//FOLDER           |
    Then the HTTP status code of responses on all endpoints should be "207"

  @skipOnOcV10 @personalSpace @Tc2cfa13c
  Scenario: send PROPPATCH requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When the user "Alice" requests these endpoints with "PROPPATCH" to set property "d:getlastmodified" with password "%regular%" about user "Alice"
      | endpoint                                            |
      | //remote.php//dav/spaces/%spaceid%/textfile1.txt    |
      | /remote.php//dav/spaces/%spaceid%/PARENT/parent.txt |
      | /remote.php//dav/spaces/%spaceid%/PARENT            |
      | //remote.php/dav//spaces/%spaceid%//FOLDER          |
    Then the HTTP status code of responses on all endpoints should be "207"


  @Ta4af698a
  Scenario: send PUT requests to webDav endpoints with 2 slashes
    When user "Alice" requests these endpoints with "PUT" including body "doesnotmatter" using password "%regular%" about user "Alice"
      | endpoint                                             |
      | //remote.php/webdav/textfile0.txt                    |
      | /remote.php//webdav/textfile1.txt                    |
      | //remote.php//dav/files/%username%/textfile1.txt     |
      | /remote.php/dav/files/%username%/textfile7.txt       |
      | //remote.php/dav/files/%username%/PARENT//parent.txt |
    Then the HTTP status code of responses on all endpoints should be "204" or "201"

  @skipOnOcV10 @personalSpace @T9f8e32f5
  Scenario: send PUT requests to webDav endpoints with 2 slashes using the spaces WebDAV API
    When user "Alice" requests these endpoints with "PUT" including body "doesnotmatter" using password "%regular%" about user "Alice"
      | endpoint                                             |
      | //remote.php/dav/spaces/%spaceid%/textfile0.txt      |
      | /remote.php//dav/spaces/%spaceid%/textfile1.txt      |
      | //remote.php//dav/spaces/%spaceid%/textfile1.txt     |
      | /remote.php/dav/spaces/%spaceid%/textfile7.txt       |
      | //remote.php/dav/spaces/%spaceid%/PARENT//parent.txt |
    Then the HTTP status code of responses on all endpoints should be "204" or "201"
