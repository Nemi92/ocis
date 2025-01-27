Feature: listing sharedWithMe when auto-sync is disabled
  As a user
  I want to get resources shared with me when auto-sync is disabled
  So that I can know about what resources I have access to

  https://owncloud.dev/libre-graph-api/#/me.drive/ListSharedWithMe

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | Brian    |
    And user "Brian" has disabled the auto-sync share


  Scenario: user lists the file shared with them when auto-sync is disabled
    Given user "Alice" has uploaded file with content "to share" to "textfile.txt"
    And user "Alice" has sent the following share invitation:
      | resource        | textfile.txt |
      | space           | Personal     |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | Viewer       |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "createdBy",
                "eTag",
                "file",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem",
                "size"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "createdBy": {
                  "type": "object",
                  "required": ["user"],
                  "properties": {
                    "user": {
                      "type": "object",
                      "required": ["displayName", "id"],
                      "properties": {
                        "displayName": {
                          "type": "string",
                          "enum": ["Alice Hansen"]
                        },
                        "id": {
                          "type": "string",
                          "pattern": "^%user_id_pattern%$"
                        }
                      }
                    }
                  }
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "file": {
                  "type": "object",
                  "required": ["mimeType"],
                  "properties": {
                    "mimeType": {
                      "type": "string",
                      "enum": ["text/plain"]
                    }
                  }
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["textfile.txt"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "createdBy",
                    "eTag",
                    "file",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions",
                    "size"
                  ],
                  "properties": {
                    "createdBy": {
                      "type": "object",
                      "required": ["user"],
                      "properties": {
                        "user": {
                          "type": "object",
                          "required": ["displayName","id"],
                          "properties": {
                            "displayName": {
                              "type": "string",
                              "enum": ["Alice Hansen"]
                            },
                            "id": {
                              "type": "string",
                              "pattern": "^%user_id_pattern%$"
                            }
                          }
                        }
                      }
                    },
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "file": {
                      "type": "object",
                      "required": ["mimeType"],
                      "properties": {
                        "mimeType": {
                          "type": "string",
                          "enum": ["text/plain"]
                        }
                      }
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["textfile.txt"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["personal"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["user"],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["Brian Murphy"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%user_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    },
                    "size": {
                      "type": "number",
                      "enum": [8]
                    }
                  }
                },
                "size": {
                  "type": "number",
                  "enum": [8]
                }
              }
            }
          }
        }
      }
      """


  Scenario: user lists the folder shared with them when auto-sync is disabled
    Given user "Alice" has created folder "folderToShare"
    And user "Alice" has sent the following share invitation:
      | resource        | folderToShare |
      | space           | Personal      |
      | sharee          | Brian         |
      | shareType       | user          |
      | permissionsRole | Viewer        |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "createdBy",
                "eTag",
                "folder",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "createdBy": {
                  "type": "object",
                  "required": ["user"],
                  "properties": {
                    "user": {
                      "type": "object",
                      "required": ["displayName", "id"],
                      "properties": {
                        "displayName": {
                          "type": "string",
                          "enum": ["Alice Hansen"]
                        },
                        "id": {
                          "type": "string",
                          "pattern": "^%user_id_pattern%$"
                        }
                      }
                    }
                  }
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["folderToShare"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "createdBy",
                    "eTag",
                    "folder",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions"
                  ],
                  "properties": {
                    "createdBy": {
                      "type": "object",
                      "required": ["user"],
                      "properties": {
                        "user": {
                          "type": "object",
                          "required": ["displayName","id"],
                          "properties": {
                            "displayName": {
                              "type": "string",
                              "enum": ["Alice Hansen"]
                            },
                            "id": {
                              "type": "string",
                              "pattern": "^%user_id_pattern%$"
                            }
                          }
                        }
                      }
                    },
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["folderToShare"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["personal"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["user"],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["Brian Murphy"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%user_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
      """


  Scenario: group member lists the file shared with them when auto-sync is disabled
    Given user "Carol" has been created with default attributes and without skeleton files
    And group "grp1" has been created
    And the following users have been added to the following groups
      | username | groupname |
      | Brian    | grp1      |
    And user "Alice" has uploaded file with content "to share" to "textfile.txt"
    And user "Alice" has sent the following share invitation:
      | resource        | textfile.txt |
      | space           | Personal     |
      | sharee          | grp1         |
      | shareType       | group        |
      | permissionsRole | Viewer       |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "createdBy",
                "eTag",
                "file",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem",
                "size"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "createdBy": {
                  "type": "object",
                  "required": ["user"],
                  "properties": {
                    "user": {
                      "type": "object",
                      "required": ["displayName", "id"],
                      "properties": {
                        "displayName": {
                          "type": "string",
                          "enum": ["Alice Hansen"]
                        },
                        "id": {
                          "type": "string",
                          "pattern": "^%user_id_pattern%$"
                        }
                      }
                    }
                  }
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "file": {
                  "type": "object",
                  "required": ["mimeType"],
                  "properties": {
                    "mimeType": {
                      "type": "string",
                      "enum": ["text/plain"]
                    }
                  }
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["textfile.txt"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "createdBy",
                    "eTag",
                    "file",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions",
                    "size"
                  ],
                  "properties": {
                    "createdBy": {
                      "type": "object",
                      "required": ["user"],
                      "properties": {
                        "user": {
                          "type": "object",
                          "required": ["displayName","id"],
                          "properties": {
                            "displayName": {
                              "type": "string",
                              "enum": ["Alice Hansen"]
                            },
                            "id": {
                              "type": "string",
                              "pattern": "^%user_id_pattern%$"
                            }
                          }
                        }
                      }
                    },
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "file": {
                      "type": "object",
                      "required": ["mimeType"],
                      "properties": {
                        "mimeType": {
                          "type": "string",
                          "enum": ["text/plain"]
                        }
                      }
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["textfile.txt"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["personal"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["group"],
                              "properties": {
                                "group": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["grp1"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%group_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    },
                    "size": {
                      "type": "number",
                      "enum": [8]
                    }
                  }
                },
                "size": {
                  "type": "number",
                  "enum": [8]
                }
              }
            }
          }
        }
      }
      """


  Scenario: group member lists the folder shared with them when auto-sync is disabled
    Given user "Carol" has been created with default attributes and without skeleton files
    And group "grp1" has been created
    And the following users have been added to the following groups
      | username | groupname |
      | Brian    | grp1      |
    And user "Alice" has created folder "folderToShare"
    And user "Alice" has sent the following share invitation:
      | resource        | folderToShare |
      | space           | Personal      |
      | sharee          | grp1          |
      | shareType       | group         |
      | permissionsRole | Viewer        |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "createdBy",
                "eTag",
                "folder",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "createdBy": {
                  "type": "object",
                  "required": ["user"],
                  "properties": {
                    "user": {
                      "type": "object",
                      "required": ["displayName", "id"],
                      "properties": {
                        "displayName": {
                          "type": "string",
                          "enum": ["Alice Hansen"]
                        },
                        "id": {
                          "type": "string",
                          "pattern": "^%user_id_pattern%$"
                        }
                      }
                    }
                  }
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["folderToShare"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "createdBy",
                    "eTag",
                    "folder",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions"
                  ],
                  "properties": {
                    "createdBy": {
                      "type": "object",
                      "required": ["user"],
                      "properties": {
                        "user": {
                          "type": "object",
                          "required": ["displayName","id"],
                          "properties": {
                            "displayName": {
                              "type": "string",
                              "enum": ["Alice Hansen"]
                            },
                            "id": {
                              "type": "string",
                              "pattern": "^%user_id_pattern%$"
                            }
                          }
                        }
                      }
                    },
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["folderToShare"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["personal"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["group"],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["grp1"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%group_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
      """


  Scenario: user lists file shares shared with them from project-space when auto-sync is disabled
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has sent the following share invitation:
      | resource        | textfile.txt |
      | space           | projectSpace |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | Viewer       |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "eTag",
                "file",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem",
                "size"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "file": {
                  "type": "object",
                  "required": ["mimeType"],
                  "properties": {
                    "mimeType": {
                      "type": "string",
                      "enum": ["text/plain"]
                    }
                  }
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["textfile.txt"]
                },
                "parentReference": {
                  "type": "object",
                  "required": [
                    "driveId",
                    "driveType",
                    "id"
                  ],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "eTag",
                    "file",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions",
                    "size"
                  ],
                  "properties": {
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "file": {
                      "type": "object",
                      "required": ["mimeType"],
                      "properties": {
                        "mimeType": {
                          "type": "string",
                          "enum": ["text/plain"]
                        }
                      }
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["textfile.txt"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": [
                        "driveId",
                        "driveType"
                      ],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["project"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                            "grantedToV2",
                            "id",
                            "invitation",
                            "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["user"],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": [
                                    "displayName",
                                    "id"
                                  ],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["Brian Murphy"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%user_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": [
                                      "displayName",
                                      "id"
                                    ],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    },
                    "size": {
                      "type": "number",
                      "enum": [8]
                    }
                  }
                },
                "size": {
                  "type": "number",
                  "enum": [8]
                }
              }
            }
          }
        }
      }
      """


  Scenario: user lists folder shares shared with them from project-space when auto-sync is disabled
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    And user "Alice" has sent the following share invitation:
      | resource        | folderToShare |
      | space           | projectSpace  |
      | sharee          | Brian         |
      | shareType       | user          |
      | permissionsRole | Viewer        |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["value"],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "eTag",
                "folder",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "folder": {
                  "type": "object"
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["folderToShare"]
                },
                "parentReference": {
                  "type": "object",
                  "required": [
                    "driveId",
                    "driveType",
                    "id"
                  ],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "eTag",
                    "folder",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions"
                  ],
                  "properties": {
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["folderToShare"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": [
                        "driveId",
                        "driveType"
                      ],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["project"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                            "grantedToV2",
                            "id",
                            "invitation",
                            "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": [
                                "user"
                              ],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": [
                                    "displayName",
                                    "id"
                                  ],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["Brian Murphy"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%user_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": [
                                  "user"
                                ],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": [
                                      "displayName",
                                      "id"
                                    ],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
      """


  Scenario: group member lists the file shared with them from project-space when auto-sync is disabled
    Given using spaces DAV path
    And user "Carol" has been created with default attributes and without skeleton files
    And group "grp1" has been created
    And the following users have been added to the following groups
      | username | groupname |
      | Brian    | grp1      |
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has sent the following share invitation:
      | resource        | textfile.txt |
      | space           | projectSpace |
      | sharee          | grp1         |
      | shareType       | group        |
      | permissionsRole | Viewer       |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "eTag",
                "file",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem",
                "size"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "file": {
                  "type": "object",
                  "required": ["mimeType"],
                  "properties": {
                    "mimeType": {
                      "type": "string",
                      "enum": ["text/plain"]
                    }
                  }
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["textfile.txt"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "eTag",
                    "file",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions",
                    "size"
                  ],
                  "properties": {
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "file": {
                      "type": "object",
                      "required": ["mimeType"],
                      "properties": {
                        "mimeType": {
                          "type": "string",
                          "enum": ["text/plain"]
                        }
                      }
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["textfile.txt"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["project"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["group"],
                              "properties": {
                                "group": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["grp1"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%group_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    },
                    "size": {
                      "type": "number",
                      "enum": [8]
                    }
                  }
                },
                "size": {
                  "type": "number",
                  "enum": [8]
                }
              }
            }
          }
        }
      }
      """


  Scenario: group member lists the space folder shared with them from project-space when auto-sync is disabled
    Given using spaces DAV path
    And user "Carol" has been created with default attributes and without skeleton files
    And group "grp1" has been created
    And the following users have been added to the following groups
      | username | groupname |
      | Brian    | grp1      |
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    And user "Alice" has sent the following share invitation:
      | resource        | folderToShare |
      | space           | projectSpace  |
      | sharee          | grp1          |
      | shareType       | group         |
      | permissionsRole | Viewer        |
    When user "Brian" lists the shares shared with him using the Graph API
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "value"
        ],
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [
                "@UI.Hidden",
                "@client.synchronize",
                "eTag",
                "folder",
                "id",
                "lastModifiedDateTime",
                "name",
                "parentReference",
                "remoteItem"
              ],
              "properties": {
                "@UI.Hidden": {
                  "type": "boolean",
                  "enum": [false]
                },
                "@client.synchronize": {
                  "type": "boolean",
                  "enum": [false]
                },
                "eTag": {
                  "type": "string",
                  "pattern": "%etag_pattern%"
                },
                "id": {
                  "type": "string",
                  "pattern": "^%share_id_pattern%$"
                },
                "name": {
                  "type": "string",
                  "enum": ["folderToShare"]
                },
                "parentReference": {
                  "type": "object",
                  "required": ["driveId", "driveType", "id"],
                  "properties": {
                    "driveId": {
                      "type": "string",
                      "pattern": "^%space_id_pattern%$"
                    },
                    "driveType": {
                      "type": "string",
                      "enum": ["virtual"]
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    }
                  }
                },
                "remoteItem": {
                  "type": "object",
                  "required": [
                    "eTag",
                    "folder",
                    "id",
                    "lastModifiedDateTime",
                    "name",
                    "parentReference",
                    "permissions"
                  ],
                  "properties": {
                    "eTag": {
                      "type": "string",
                      "pattern": "%etag_pattern%"
                    },
                    "id": {
                      "type": "string",
                      "pattern": "^%file_id_pattern%$"
                    },
                    "name": {
                      "type": "string",
                      "enum": ["folderToShare"]
                    },
                    "parentReference": {
                      "type": "object",
                      "required": ["driveId", "driveType"],
                      "properties": {
                        "driveId": {
                          "type": "string",
                          "pattern": "^%file_id_pattern%$"
                        },
                        "driveType": {
                          "type": "string",
                          "enum": ["project"]
                        }
                      }
                    },
                    "permissions": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "required": [
                          "grantedToV2",
                          "id",
                          "invitation",
                          "roles"
                          ],
                          "properties": {
                            "grantedToV2": {
                              "type": "object",
                              "required": ["group"],
                              "properties": {
                                "user": {
                                  "type": "object",
                                  "required": ["displayName", "id"],
                                  "properties": {
                                    "displayName": {
                                      "type": "string",
                                      "enum": ["Brian Murphy"]
                                    },
                                    "id": {
                                      "type": "string",
                                      "pattern": "^%user_id_pattern%$"
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "id": {
                            "type": "string",
                            "pattern": "^%permissions_id_pattern%$"
                          },
                          "invitation": {
                            "type": "object",
                            "required": ["invitedBy"],
                            "properties": {
                              "invitedBy": {
                                "type": "object",
                                "required": ["user"],
                                "properties": {
                                  "user": {
                                    "type": "object",
                                    "required": ["displayName", "id"],
                                    "properties": {
                                      "displayName": {
                                        "type": "string",
                                        "enum": ["Alice Hansen"]
                                      },
                                      "id": {
                                        "type": "string",
                                        "pattern": "^%user_id_pattern%$"
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          },
                          "roles": {
                            "type": "array",
                            "items": [
                              {
                                "type": "string",
                                "pattern": "^%role_id_pattern%$"
                              }
                            ]
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
      """
