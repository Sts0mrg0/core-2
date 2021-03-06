@api @skipOnOcis-OC-Storage
Feature: propagation of etags when deleting a file or folder

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has created folder "/upload"

  Scenario Outline: deleting a file changes the etags of all parents
    Given using <dav_version> DAV path
    And user "Alice" has created folder "/upload/sub"
    And user "Alice" has uploaded file with content "uploaded content" to "/upload/sub/file.txt"
    And user "Alice" has stored etag of element "/<element>"
    When user "Alice" deletes file "/upload/sub/file.txt" using the WebDAV API
    Then the etag of element "/<element>" of user "Alice" should have changed
    Examples:
      | dav_version | element    |
      | old         |            |
      | old         | upload     |
      | old         | upload/sub |
      | new         |            |
      | new         | upload     |
      | new         | upload/sub |

  Scenario Outline: deleting a folder changes the etags of all parents
    Given using <dav_version> DAV path
    And user "Alice" has created folder "/upload/sub"
    And user "Alice" has created folder "/upload/sub/toDelete"
    And user "Alice" has stored etag of element "/<element>"
    When user "Alice" deletes folder "/upload/sub/toDelete" using the WebDAV API
    Then the etag of element "/<element>" of user "Alice" should have changed
    Examples:
      | dav_version | element    |
      | old         |            |
      | old         | upload     |
      | old         | upload/sub |
      | new         |            |
      | new         | upload     |
      | new         | upload/sub |

  Scenario Outline: deleting a folder with content changes the etags of all parents
    Given using <dav_version> DAV path
    And user "Alice" has created folder "/upload/sub"
    And user "Alice" has created folder "/upload/sub/toDelete"
    And user "Alice" has uploaded file with content "uploaded content" to "/upload/sub/toDelete/file.txt"
    And user "Alice" has stored etag of element "/<element>"
    When user "Alice" deletes folder "/upload/sub/toDelete" using the WebDAV API
    Then the etag of element "/<element>" of user "Alice" should have changed
    Examples:
      | dav_version | element    |
      | old         |            |
      | old         | upload     |
      | old         | upload/sub |
      | new         |            |
      | new         | upload     |
      | new         | upload/sub |
