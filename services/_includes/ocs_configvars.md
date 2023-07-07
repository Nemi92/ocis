## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>OCS_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>OCS_TRACING_TYPE | string |  | The type of tracing. Defaults to '', which is the same as 'jaeger'. Allowed tracing types are 'jaeger' and '' as of now.|
| OCIS_TRACING_ENDPOINT<br/>OCS_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>OCS_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>OCS_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>OCS_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>OCS_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>OCS_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| OCS_DEBUG_ADDR | string | 127.0.0.1:9114 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| OCS_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| OCS_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| OCS_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| OCS_HTTP_ADDR | string | 127.0.0.1:9110 | The bind address of the HTTP service.|
| OCS_HTTP_ROOT | string | /ocs | Subdirectory that serves as the root for this HTTP service.|
| OCIS_CORS_ALLOW_ORIGINS<br/>OCS_CORS_ALLOW_ORIGINS | []string | [*] | A comma-separated list of allowed CORS origins. See following chapter for more details: *Access-Control-Allow-Origin* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin|
| OCIS_CORS_ALLOW_METHODS<br/>OCS_CORS_ALLOW_METHODS | []string | [GET POST PUT PATCH DELETE OPTIONS] | A comma-separated list of allowed CORS methods. See following chapter for more details: *Access-Control-Request-Method* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Method|
| OCIS_CORS_ALLOW_HEADERS<br/>OCS_CORS_ALLOW_HEADERS | []string | [Authorization Origin Content-Type Accept X-Requested-With X-Request-Id] | A blank or comma-separated list of allowed CORS headers. See following chapter for more details: *Access-Control-Request-Headers* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Request-Headers.|
| OCIS_CORS_ALLOW_CREDENTIALS<br/>OCS_CORS_ALLOW_CREDENTIALS | bool | true | Allow credentials for CORS.See following chapter for more details: *Access-Control-Allow-Credentials* at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Credentials.|
| OCIS_HTTP_TLS_ENABLED | bool | false | Activates TLS for the http based services using the server certifcate and key configured via OCIS_HTTP_TLS_CERTIFICATE and OCIS_HTTP_TLS_KEY. If OCIS_HTTP_TLS_CERTIFICATE is not set a temporary server certificate is generated - to be used with PROXY_INSECURE_BACKEND=true.|
| OCIS_HTTP_TLS_CERTIFICATE | string |  | Path/File name of the TLS server certificate (in PEM format) for the http services.|
| OCIS_HTTP_TLS_KEY | string |  | Path/File name for the TLS certificate key (in PEM format) for the server certificate to use for the http services.|
| OCIS_JWT_SECRET<br/>OCS_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|