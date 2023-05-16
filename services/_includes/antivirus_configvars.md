## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_LOG_LEVEL<br/>ANTIVIRUS_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>ANTIVIRUS_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>ANTIVIRUS_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>ANTIVIRUS_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| ANTIVIRUS_DEBUG_ADDR | string | 127.0.0.1:9277 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| ANTIVIRUS_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| ANTIVIRUS_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| ANTIVIRUS_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| ANTIVIRUS_INFECTED_FILE_HANDLING | string | delete | Defines the behaviour when a virus has been found. Supported options are: 'delete', 'continue' and 'abort '. Delete will delete the file. Continue will mark the file as infected but continues further processing. Abort will keep the file in the uploads folder for further admin inspection and will not move it to its final destination.|
| OCIS_EVENTS_ENDPOINT<br/>ANTIVIRUS_EVENTS_ENDPOINT | string | 127.0.0.1:9233 | The address of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture.|
| OCIS_EVENTS_CLUSTER<br/>ANTIVIRUS_EVENTS_CLUSTER | string | ocis-cluster | The clusterID of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture. Mandatory when using NATS as event system.|
| OCIS_INSECURE<br/>ANTIVIRUS_EVENTS_TLS_INSECURE | bool | false | Whether to verify the server TLS certificates.|
| ANTIVIRUS_EVENTS_TLS_ROOT_CA_CERTIFICATE | string |  | The root CA certificate used to validate the server's TLS certificate. If provided ANTIVIRUS_EVENTS_TLS_INSECURE will be seen as false.|
| OCIS_EVENTS_ENABLE_TLS<br/>ANTIVIRUS_EVENTS_ENABLE_TLS | bool | false | Enable TLS for the connection to the events broker. The events broker is the ocis service which receives and delivers events between the services.|
| ANTIVIRUS_SCANNER_TYPE | string | clamav | The antivirus scanner to use. Supported values are 'clamav' and 'icap'.|
| ANTIVIRUS_CLAMAV_SOCKET | string | /run/clamav/clamd.ctl | The socket clamav is running on. Note the default value is an example which needs adaption according your OS.|
| ANTIVIRUS_ICAP_TIMEOUT | int64 | 300 | Timeout for the ICAP client.|
| ANTIVIRUS_ICAP_URL | string | icap://127.0.0.1:1344 | URL of the ICAP server.|
| ANTIVIRUS_ICAP_SERVICE | string | avscan | The name of the ICAP service.|
| ANTIVIRUS_MAX_SCAN_SIZE | string |  | The maximum scan size the virusscanner can handle. Only this many bytes of a file will be scanned. 0 means unlimited and is the default. Usable common abbreviations: [KB, KiB, GB, GiB, TB, TiB, PB, PiB, EB, EiB], example: 2GB.|
| ANTIVIRUS_DEBUG_SCAN_OUTCOME | string |  | A predefined outcome for virus scanning, FOR DEBUG PURPOSES ONLY! (example values: "found,infected")|