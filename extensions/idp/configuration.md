---
title: "Configuration"
date: "2021-09-27T11:09:38+0000"
weight: 20
geekdocRepo: https://github.com/owncloud/ocis
geekdocEditPath: edit/master/idp/templates
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

For this configuration to be picked up, have a look at your extension `root` command and look for which default config name it has assigned. *i.e: ocis-idp reads `idp.json | yaml | toml ...`*.

So far we support the file formats `JSON` and `YAML`, if you want to get a full example configuration just take a look at [our repository](https://github.com/owncloud/ocis/tree/master/idp/config), there you can always see the latest configuration format. These example configurations include all available options and the default values. The configuration file will be automatically loaded if it's placed at `/etc/ocis/ocis.yml`, `${HOME}/.ocis/ocis.yml` or `$(pwd)/config/ocis.yml`.

### Environment variables

If you prefer to configure the service with environment variables you can see the available variables below.

If multiple variables are listed for one option, they are in order of precedence. This means the leftmost variable will always win if given.

### Command-line flags

If you prefer to configure the service with command-line flags you can see the available variables below. Command line flags are only working when calling the subcommand directly.

### idp health

Check health status

Usage: `idp health [command options] [arguments...]`





-debug-addr |  $IDP_DEBUG_ADDR
: Address to debug endpoint. Default: `"0.0.0.0:9134"`.


























































### idp ocis-idp

Serve IDP API for oCIS

Usage: `idp ocis-idp [command options] [arguments...]`


-log-level |  $IDP_LOG_LEVEL , $OCIS_LOG_LEVEL
: Set logging level.


-log-pretty |  $IDP_LOG_PRETTY , $OCIS_LOG_PRETTY
: Enable pretty logging.


-log-color |  $IDP_LOG_COLOR , $OCIS_LOG_COLOR
: Enable colored logging.



























































### idp server

Start integrated server

Usage: `idp server [command options] [arguments...]`






-log-file |  $IDP_LOG_FILE , $OCIS_LOG_FILE
: Enable log to file.


-config-file |  $IDP_CONFIG_FILE
: Path to config file. Default: `""`.


-tracing-enabled |  $IDP_TRACING_ENABLED , $OCIS_TRACING_ENABLED
: Enable sending traces.


-tracing-type |  $IDP_TRACING_TYPE , $OCIS_TRACING_TYPE
: Tracing backend type. Default: `"jaeger"`.


-tracing-endpoint |  $IDP_TRACING_ENDPOINT , $OCIS_TRACING_ENDPOINT
: Endpoint for the agent. Default: `""`.


-tracing-collector |  $IDP_TRACING_COLLECTOR , $OCIS_TRACING_COLLECTOR
: Endpoint for the collector. Default: `""`.


-tracing-service |  $IDP_TRACING_SERVICE
: Service name for tracing. Default: `"idp"`.


-debug-addr |  $IDP_DEBUG_ADDR
: Address to bind debug server. Default: `"0.0.0.0:9134"`.


-debug-token |  $IDP_DEBUG_TOKEN
: Token to grant metrics access. Default: `""`.


-debug-pprof |  $IDP_DEBUG_PPROF
: Enable pprof debugging.


-debug-zpages |  $IDP_DEBUG_ZPAGES
: Enable zpages debugging.


-http-addr |  $IDP_HTTP_ADDR
: Address to bind http server. Default: `"0.0.0.0:9130"`.


-http-root |  $IDP_HTTP_ROOT
: Root path of http server. Default: `"/"`.


-http-namespace |  $IDP_HTTP_NAMESPACE
: Set the base namespace for service discovery. Default: `"com.owncloud.web"`.


-name |  $IDP_NAME
: Service name. Default: `"idp"`.


-identity-manager |  $IDP_IDENTITY_MANAGER
: Identity manager (one of ldap,kc,cookie,dummy). Default: `"ldap"`.


-ldap-uri |  $IDP_LDAP_URI
: URI of the LDAP server (glauth). Default: `"ldap://localhost:9125"`.


-ldap-bind-dn |  $IDP_LDAP_BIND_DN
: Bind DN for the LDAP server (glauth). Default: `"cn=idp,ou=sysusers,dc=example,dc=org"`.


-ldap-bind-password |  $IDP_LDAP_BIND_PASSWORD
: Password for the Bind DN of the LDAP server (glauth). Default: `"idp"`.


-ldap-base-dn |  $IDP_LDAP_BASE_DN
: LDAP base DN of the oCIS users. Default: `"ou=users,dc=example,dc=org"`.


-ldap-scope |  $IDP_LDAP_SCOPE
: LDAP scope of the oCIS users. Default: `"sub"`.


-ldap-login-attribute |  $IDP_LDAP_LOGIN_ATTRIBUTE
: LDAP login attribute of the oCIS users. Default: `"cn"`.


-ldap-email-attribute |  $IDP_LDAP_EMAIL_ATTRIBUTE
: LDAP email attribute of the oCIS users. Default: `"mail"`.


-ldap-name-attribute |  $IDP_LDAP_NAME_ATTRIBUTE
: LDAP name attribute of the oCIS users. Default: `"sn"`.


-ldap-uuid-attribute |  $IDP_LDAP_UUID_ATTRIBUTE
: LDAP UUID attribute of the oCIS users. Default: `"uid"`.


-ldap-uuid-attribute-type |  $IDP_LDAP_UUID_ATTRIBUTE_TYPE
: LDAP UUID attribute type of the oCIS users. Default: `"text"`.


-ldap-filter |  $IDP_LDAP_FILTER
: LDAP filter of the oCIS users. Default: `"(objectClass=posixaccount)"`.


-transport-tls-cert |  $IDP_TRANSPORT_TLS_CERT
: Certificate file for transport encryption. Default: `flags.OverrideDefaultString(cfg.HTTP.TLSCert, path.Join(pkgos.MustUserConfigDir("ocis", "idp"), "server.crt"))`.


-transport-tls-key |  $IDP_TRANSPORT_TLS_KEY
: Secret file for transport encryption. Default: `flags.OverrideDefaultString(cfg.HTTP.TLSKey, path.Join(pkgos.MustUserConfigDir("ocis", "idp"), "server.key"))`.


-iss |  $IDP_ISS , $OCIS_URL
: OIDC issuer URL. Default: `"https://localhost:9200"`.


-signing-private-key |  $IDP_SIGNING_PRIVATE_KEY
: Full path to PEM encoded private key file (must match the --signing-method algorithm). Default: `nil`.


-signing-kid |  $IDP_SIGNING_KID
: Value of kid field to use in created tokens (uniquely identifying the signing-private-key). Default: `""`.


-validation-keys-path |  $IDP_VALIDATION_KEYS_PATH
: Full path to a folder containing PEM encoded private or public key files used for token validation (file name without extension is used as kid). Default: `""`.


-encryption-secret |  $IDP_ENCRYPTION_SECRET
: Full path to a file containing a %d bytes secret key. Default: `""`.


-signing-method |  $IDP_SIGNING_METHOD
: JWT default signing method. Default: `"PS256"`.


-uri-base-path |  $IDP_URI_BASE_PATH
: Custom base path for URI endpoints. Default: `""`.


-sign-in-uri |  $IDP_SIGN_IN_URI
: Custom redirection URI to sign-in form. Default: `""`.


-signed-out-uri |  $IDP_SIGN_OUT_URI
: Custom redirection URI to signed-out goodbye page. Default: `""`.


-authorization-endpoint-uri |  $IDP_ENDPOINT_URI
: Custom authorization endpoint URI. Default: `""`.


-endsession-endpoint-uri |  $IDP_ENDSESSION_ENDPOINT_URI
: Custom endsession endpoint URI. Default: `""`.


-asset-path |  $IDP_ASSET_PATH
: Path to custom assets. Default: `""`.


-identifier-client-path |  $IDP_IDENTIFIER_CLIENT_PATH
: Path to the identifier web client base folder. Default: `"/var/tmp/ocis/idp"`.


-identifier-registration-conf |  $IDP_IDENTIFIER_REGISTRATION_CONF
: Path to a identifier-registration.yaml configuration file. Default: `"./config/identifier-registration.yaml"`.


-identifier-scopes-conf |  $IDP_IDENTIFIER_SCOPES_CONF
: Path to a scopes.yaml configuration file. Default: `""`.


-insecure |  $IDP_INSECURE
: Disable TLS certificate and hostname validation.


-tls |  $IDP_TLS
: Use TLS (disable only if idp is behind a TLS-terminating reverse-proxy).. Default: `false`.


-trusted-proxy |  $IDP_TRUSTED_PROXY
: Trusted proxy IP or IP network (can be used multiple times). Default: `nil`.


-allow-scope |  $IDP_ALLOW_SCOPE
: Allow OAuth 2 scope (can be used multiple times, if not set default scopes are allowed). Default: `nil`.


-allow-client-guests |  $IDP_ALLOW_CLIENT_GUESTS
: Allow sign in of client controlled guest users.


-allow-dynamic-client-registration |  $IDP_ALLOW_DYNAMIC_CLIENT_REGISTRATION
: Allow dynamic OAuth2 client registration. Default: `false`.


-disable-identifier-webapp |  $IDP_DISABLE_IDENTIFIER_WEBAPP
: Disable built-in identifier-webapp to use a frontend hosted elsewhere.. Default: `true`.


-access-token-expiration |  $IDP_ACCESS_TOKEN_EXPIRATION
: Expiration time of access tokens in seconds since generated. Default: `60 * 10`.


-id-token-expiration |  $IDP_ID_TOKEN_EXPIRATION
: Expiration time of id tokens in seconds since generated. Default: `60 * 60`.


-refresh-token-expiration |  $IDP_REFRESH_TOKEN_EXPIRATION
: Expiration time of refresh tokens in seconds since generated. Default: `60 * 60 * 24 * 365 * 3`.


-extensions | 
: Run specific extensions during supervised mode. This flag is set by the runtime.



### idp version

Print the versions of the running instances

Usage: `idp version [command options] [arguments...]`





























































-http-namespace |  $IDP_HTTP_NAMESPACE
: Set the base namespace for service discovery. Default: `"com.owncloud.web"`.


-name |  $IDP_NAME
: Service name. Default: `"idp"`.

