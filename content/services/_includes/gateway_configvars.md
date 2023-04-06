## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>GATEWAY_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>GATEWAY_TRACING_TYPE | string |  | The type of tracing. Defaults to "", which is the same as "jaeger". Allowed tracing types are "jaeger" and "" as of now.|
| OCIS_TRACING_ENDPOINT<br/>GATEWAY_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>GATEWAY_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>GATEWAY_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>GATEWAY_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>GATEWAY_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>GATEWAY_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| GATEWAY_DEBUG_ADDR | string | 127.0.0.1:9143 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| GATEWAY_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| GATEWAY_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| GATEWAY_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| GATEWAY_GRPC_ADDR | string | 127.0.0.1:9142 | The bind address of the GRPC service.|
| OCIS_GRPC_TLS_ENABLED | bool | false | Activates TLS for the grpc based services using the server certifcate and key configured via OCIS_GRPC_TLS_CERTIFICATE and OCIS_GRPC_TLS_KEY. If OCIS_GRPC_TLS_CERTIFICATE is not set a temporary server certificate is generated - to be used with OCIS_GRPC_CLIENT_TLS_MODE=insecure.|
| OCIS_GRPC_TLS_CERTIFICATE | string |  | Path/File name of the TLS server certificate (in PEM format) for the grpc services.|
| OCIS_GRPC_TLS_KEY | string |  | Path/File name for the TLS certificate key (in PEM format) for the server certificate to use for the grpc services.|
| GATEWAY_GRPC_PROTOCOL | string | tcp | The transport protocol of the GRPC service.|
| OCIS_JWT_SECRET<br/>GATEWAY_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| OCIS_GRPC_CLIENT_TLS_MODE | string |  | TLS mode for grpc connection to the go-micro based grpc services. Possible values are 'off', 'insecure' and 'on'. 'off': disables transport security for the clients. 'insecure' allows to use transport security, but disables certificate verification (to be used with the autogenerated self-signed certificates). 'on' enables transport security, including server ceritificate verification.|
| OCIS_GRPC_CLIENT_TLS_CACERT | string |  | Path/File name for the root CA certificate (in PEM format) used to validate TLS server certificates of the go-micro based grpc services.|
| GATEWAY_SKIP_USER_GROUPS_IN_TOKEN | bool | false | Disables the loading of user's group memberships from the reva access token.|
| GATEWAY_COMMIT_SHARE_TO_STORAGE_GRANT | bool | true | Commit shares to storage grants. This grants access to shared resources for the share receiver directly on the storage.|
| GATEWAY_SHARE_FOLDER_NAME | string | Shares | Name of the share folder in users' home space.|
| GATEWAY_DISABLE_HOME_CREATION_ON_LOGIN | bool | true | Disable creation of the home space on login.|
| STORAGE_TRANSFER_SECRET | string |  | The storage transfer secret.|
| GATEWAY_TRANSFER_EXPIRES | int | 86400 | Expiry for the gateway tokens.|
| OCIS_CACHE_STORE_TYPE<br/>GATEWAY_CACHE_STORE_TYPE<br/>GATEWAY_CACHE_STORE | string | memory | Store implementation for the cache. Valid values are "memory" (default), "redis", and "etcd".|
| OCIS_CACHE_STORE_ADDRESS<br/>GATEWAY_CACHE_STORE_ADDRESS<br/>GATEWAY_CACHE_NODES | []string | [] | Node addresses to use for the cache store.|
| GATEWAY_CACHE_DATABASE | string | users | Database name of the cache.|
| GATEWAY_STAT_CACHE_TTL | int | 300 | Max TTL in seconds for the gateway's stat cache.|
| GATEWAY_PROVIDER_CACHE_TTL | int | 300 | Max TTL in seconds for the gateway's provider cache.|
| GATEWAY_CREATE_HOME_CACHE_TTL | int | 300 | Max TTL in seconds for the gateway's create home cache.|
| OCIS_URL<br/>GATEWAY_FRONTEND_PUBLIC_URL | string | https://localhost:9200 | The public facing URL of the oCIS frontend.|
| GATEWAY_USERS_ENDPOINT | string | localhost:9144 | The USERS API endpoint.|
| GATEWAY_GROUPS_ENDPOINT | string | localhost:9160 | The GROUPS API endpoint.|
| GATEWAY_PERMISSIONS_ENDPOINT | string | localhost:9191 | The SETTINGS API endpoint.|
| GATEWAY_SHARING_ENDPOINT | string | localhost:9150 | The SHARE API endpoint.|
| GATEWAY_AUTH_BASIC_ENDPOINT | string | localhost:9146 | The AUTH BASIC API endpoint.|
| GATEWAY_AUTH_BEARER_ENDPOINT | string |  | The AUTH BEARER API endpoint.|
| GATEWAY_AUTH_MACHINE_ENDPOINT | string | localhost:9166 | The AUTH MACHINE API endpoint.|
| GATEWAY_STORAGE_PUBLIC_LINK_ENDPOINT | string | localhost:9178 | The STORAGE PUBLICLINK API endpoint.|
| GATEWAY_STORAGE_USERS_ENDPOINT | string | localhost:9157 | The STORAGE USERS API endpoint.|
| GATEWAY_STORAGE_SHARES_ENDPOINT | string | localhost:9154 | The STORAGE SHARES API endpoint.|
| GATEWAY_APP_REGISTRY_ENDPOINT | string | localhost:9242 | The APP REGISTRY API endpoint.|
| GATEWAY_STORAGE_USERS_MOUNT_ID | string |  | Mount ID of this storage. Admins can set the ID for the storage in this config option manually which is then used to reference the storage. Any reasonable long string is possible, preferably this would be an UUIDv4 format.|