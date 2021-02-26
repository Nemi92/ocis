---
title: "Configuration"
date: "2021-02-26T10:00:09+0000"
weight: 20
geekdocRepo: https://github.com/owncloud/ocis
geekdocEditPath: edit/master/onlyoffice/templates
geekdocFilePath: CONFIGURATION.tmpl
---

{{< toc >}}

## Configuration

oCIS Single Binary is not responsible for configuring extensions. Instead, each extension could either be configured by environment variables, cli flags or config files.

Each extension has its dedicated documentation page (e.g. https://owncloud.github.io/extensions/onlyoffice/configuration) which lists all possible configurations. Config files and environment variables are picked up if you use the `./bin/ocis server` command within the oCIS single binary. Command line flags must be set explicitly on the extensions subcommands.

### Configuration using config files

Out of the box extensions will attempt to read configuration details from:

```console
/etc/ocis
$HOME/.ocis
./config
```

For this configuration to be picked up, have a look at your extension `root` command and look for which default config name it has assigned. *i.e: onlyoffice reads `onlyoffice.json | yaml | toml ...`*.

So far we support the file formats `JSON` and `YAML`, if you want to get a full example configuration just take a look at [our repository](https://github.com/owncloud/ocis/tree/master/onlyoffice/config), there you can always see the latest configuration format. These example configurations include all available options and the default values. The configuration file will be automatically loaded if it's placed at `/etc/ocis/ocis.yml`, `${HOME}/.ocis/ocis.yml` or `$(pwd)/config/ocis.yml`.

### Environment variables

If you prefer to configure the service with environment variables you can see the available variables below.

If multiple variables are listed for one option, they are in order of precedence. This means the leftmost variable will always win if given.

### Commandline flags

If you prefer to configure the service with commandline flags you can see the available variables below. Command line flags are only working when calling the subcommand directly.

## Root Command

OnlyOffice oCIS extension

Usage: `onlyoffice [global options] command [command options] [arguments...]`

-config-file |  $ONLYOFFICE_CONFIG_FILE
: Path to config file.

-log-level |  $ONLYOFFICE_LOG_LEVEL
: Set logging level. Default: `info`.

-log-pretty |  $ONLYOFFICE_LOG_PRETTY
: Enable pretty logging. Default: `true`.

-log-color |  $ONLYOFFICE_LOG_COLOR
: Enable colored logging. Default: `true`.

## Sub Commands

### onlyoffice health

Check health status

Usage: `onlyoffice health [command options] [arguments...]`

-debug-addr |  $ONLYOFFICE_DEBUG_ADDR
: Address to debug endpoint. Default: `0.0.0.0:9224`.

### onlyoffice server

Start integrated server

Usage: `onlyoffice server [command options] [arguments...]`

-tracing-enabled |  $ONLYOFFICE_TRACING_ENABLED
: Enable sending traces.

-tracing-type |  $ONLYOFFICE_TRACING_TYPE
: Tracing backend type. Default: `jaeger`.

-tracing-endpoint |  $ONLYOFFICE_TRACING_ENDPOINT
: Endpoint for the agent.

-tracing-collector |  $ONLYOFFICE_TRACING_COLLECTOR
: Endpoint for the collector.

-tracing-service |  $ONLYOFFICE_TRACING_SERVICE
: Service name for tracing. Default: `onlyoffice`.

-debug-addr |  $ONLYOFFICE_DEBUG_ADDR
: Address to bind debug server. Default: `0.0.0.0:9224`.

-debug-token |  $ONLYOFFICE_DEBUG_TOKEN
: Token to grant metrics access.

-debug-pprof |  $ONLYOFFICE_DEBUG_PPROF
: Enable pprof debugging.

-debug-zpages |  $ONLYOFFICE_DEBUG_ZPAGES
: Enable zpages debugging.

-http-addr |  $ONLYOFFICE_HTTP_ADDR
: Address to bind http server. Default: `0.0.0.0:9220`.

-http-namespace |  $ONLYOFFICE_HTTP_NAMESPACE
: Set the base namespace for the http namespace. Default: `com.owncloud.web`.

-http-root |  $ONLYOFFICE_HTTP_ROOT
: Root path of http server. Default: `/`.

-asset-path |  $ONLYOFFICE_ASSET_PATH
: Path to custom assets.

