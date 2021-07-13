---
title: "Configuration"
date: "2021-07-13T02:43:31+0000"
weight: 20
geekdocRepo: https://github.com/owncloud/ocis
geekdocEditPath: edit/master/accounts/templates
geekdocFilePath: CONFIGURATION.tmpl
---

{{< toc >}}

## Configuration

### Configuration using config files

Out of the box extensions will attempt to read configuration details from:

```console
/etc/ocis
$HOME/.ocis
./config
```

For this configuration to be picked up, have a look at your extension `root` command and look for which default config name it has assigned. *i.e: ocis-accounts reads `accounts.json | yaml | toml ...`*.

So far we support the file formats `JSON` and `YAML`, if you want to get a full example configuration just take a look at [our repository](https://github.com/owncloud/ocis/tree/master/accounts/config), there you can always see the latest configuration format. These example configurations include all available options and the default values. The configuration file will be automatically loaded if it's placed at `/etc/ocis/ocis.yml`, `${HOME}/.ocis/ocis.yml` or `$(pwd)/config/ocis.yml`.

### Environment variables

If you prefer to configure the service with environment variables you can see the available variables below.

If multiple variables are listed for one option, they are in order of precedence. This means the leftmost variable will always win if given.

### Commandline flags

If you prefer to configure the service with commandline flags you can see the available variables below. Command line flags are only working when calling the subcommand directly.

### accounts version

Print the versions of the running instances

Usage: `accounts version [command options] [arguments...]`

































































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.





### accounts add

Create a new account

Usage: `accounts add [command options] [arguments...]`


















































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.


-enabled | 
: Enable the account.


-displayname | 
: Set the displayname for the account.


-username | 
: Username will be written to preferred-name and on_premises_sam_account_name.


-preferred-name | 
: Set the preferred-name for the account.


-on-premises-sam-account-name | 
: Set the on-premises-sam-account-name.


-uidnumber | 
: Set the uidnumber for the account.


-gidnumber | 
: Set the gidnumber for the account.


-mail | 
: Set the mail for the account.


-description | 
: Set the description for the account.


-password | 
: Set the password for the account.


-password-policies | 
: Possible policies: DisableStrongPassword, DisablePasswordExpiration.


-force-password-change | 
: Force password change on next sign-in.


-force-password-change-mfa | 
: Force password change on next sign-in with mfa.







### accounts list

List existing accounts

Usage: `accounts list [command options] [arguments...]`

































































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.





### accounts rebuildIndex

Rebuilds the service's index, i.e. deleting and then re-adding all existing documents

Usage: `accounts rebuildIndex [command options] [arguments...]`






































































### accounts server

Start ocis accounts service

Usage: `accounts server [command options] [arguments...]`






-log-file |  $ACCOUNTS_LOG_FILE , $OCIS_LOG_FILE
: Enable log to file.


-tracing-enabled |  $ACCOUNTS_TRACING_ENABLED
: Enable sending traces.


-tracing-type |  $ACCOUNTS_TRACING_TYPE
: Tracing backend type. Default: `"jaeger"`.


-tracing-endpoint |  $ACCOUNTS_TRACING_ENDPOINT
: Endpoint for the agent. Default: `""`.


-tracing-collector |  $ACCOUNTS_TRACING_COLLECTOR
: Endpoint for the collector. Default: `""`.


-tracing-service |  $ACCOUNTS_TRACING_SERVICE
: Service name for tracing. Default: `"accounts"`.


-http-namespace |  $ACCOUNTS_HTTP_NAMESPACE
: Set the base namespace for the http namespace. Default: `"com.owncloud.web"`.


-http-addr |  $ACCOUNTS_HTTP_ADDR
: Address to bind http server. Default: `"0.0.0.0:9181"`.


-http-root |  $ACCOUNTS_HTTP_ROOT
: Root path of http server. Default: `"/"`.


-http-cache-ttl |  $ACCOUNTS_CACHE_TTL
: Set the static assets caching duration in seconds. Default: `604800`.


-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-grpc-addr |  $ACCOUNTS_GRPC_ADDR
: Address to bind grpc server. Default: `"0.0.0.0:9180"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.


-accounts-hash-difficulty |  $ACCOUNTS_HASH_DIFFICULTY
: accounts password hash difficulty. Default: `11`.


-asset-path |  $ACCOUNTS_ASSET_PATH
: Path to custom assets. Default: `""`.


-jwt-secret |  $ACCOUNTS_JWT_SECRET , $OCIS_JWT_SECRET
: Used to create JWT to talk to reva, should equal reva's jwt-secret. Default: `"Pive-Fumkiu4"`.


-storage-disk-path |  $ACCOUNTS_STORAGE_DISK_PATH
: Path on the local disk, e.g. /var/tmp/ocis/accounts. Default: `""`.


-storage-cs3-provider-addr |  $ACCOUNTS_STORAGE_CS3_PROVIDER_ADDR
: bind address for the metadata storage provider. Default: `"localhost:9215"`.


-storage-cs3-data-url |  $ACCOUNTS_STORAGE_CS3_DATA_URL
: http endpoint of the metadata storage. Default: `"http://localhost:9216"`.


-storage-cs3-data-prefix |  $ACCOUNTS_STORAGE_CS3_DATA_PREFIX
: path prefix for the http endpoint of the metadata storage, without leading slash. Default: `"data"`.


-storage-cs3-jwt-secret |  $ACCOUNTS_STORAGE_CS3_JWT_SECRET , $OCIS_JWT_SECRET
: Used to create JWT to talk to reva, should equal reva's jwt-secret. Default: `"Pive-Fumkiu4"`.


-service-user-uuid |  $ACCOUNTS_SERVICE_USER_UUID
: uuid of the internal service user (required on EOS). Default: `"95cb8724-03b2-11eb-a0a6-c33ef8ef53ad"`.


-service-user-username |  $ACCOUNTS_SERVICE_USER_USERNAME
: username of the internal service user (required on EOS). Default: `""`.


-service-user-uid |  $ACCOUNTS_SERVICE_USER_UID
: uid of the internal service user (required on EOS). Default: `0`.


-service-user-gid |  $ACCOUNTS_SERVICE_USER_GID
: gid of the internal service user (required on EOS). Default: `0`.


-uid-index-lower-bound |  $ACCOUNTS_UID_INDEX_LOWER_BOUND
: define a starting point for the account UID. Default: `0`.


-gid-index-lower-bound |  $ACCOUNTS_GID_INDEX_LOWER_BOUND
: define a starting point for the account GID. Default: `1000`.


-uid-index-upper-bound |  $ACCOUNTS_UID_INDEX_UPPER_BOUND
: define an ending point for the account UID. Default: `0`.


-gid-index-upper-bound |  $ACCOUNTS_GID_INDEX_UPPER_BOUND
: define an ending point for the account GID. Default: `1000`.


-extensions | 
: Run specific extensions during supervised mode.




































### accounts inspect

Show detailed data on an existing account

Usage: `accounts inspect [command options] [arguments...]`





































































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.

### accounts remove

Removes an existing account

Usage: `accounts remove [command options] [arguments...]`



































































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.



### accounts ocis-accounts

Provide accounts and groups for oCIS

Usage: `accounts ocis-accounts [command options] [arguments...]`


-log-level |  $ACCOUNTS_LOG_LEVEL , $OCIS_LOG_LEVEL
: Set logging level.


-log-pretty |  $ACCOUNTS_LOG_PRETTY , $OCIS_LOG_PRETTY
: Enable pretty logging.


-log-color |  $ACCOUNTS_LOG_COLOR , $OCIS_LOG_COLOR
: Enable colored logging.


-extensions | 
: Run specific extensions during supervised mode.


































































### accounts update

Make changes to an existing account

Usage: `accounts update [command options] [arguments...]`




































-grpc-namespace |  $ACCOUNTS_GRPC_NAMESPACE
: Set the base namespace for the grpc namespace. Default: `"com.owncloud.api"`.


-name |  $ACCOUNTS_NAME
: service name. Default: `"accounts"`.


-enabled | 
: Enable the account.


-displayname | 
: Set the displayname for the account.


-preferred-name | 
: Set the preferred-name for the account.


-on-premises-sam-account-name | 
: Set the on-premises-sam-account-name.


-uidnumber | 
: Set the uidnumber for the account.


-gidnumber | 
: Set the gidnumber for the account.


-mail | 
: Set the mail for the account.


-description | 
: Set the description for the account.


-password | 
: Set the password for the account.


-password-policies | 
: Possible policies: DisableStrongPassword, DisablePasswordExpiration.


-force-password-change | 
: Force password change on next sign-in.


-force-password-change-mfa | 
: Force password change on next sign-in with mfa.






















