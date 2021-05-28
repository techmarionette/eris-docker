# Eris

> Author: Dom Davis (CTO)
> &copy; Tech Marionette Limited 2021

_Eris_ provides an interface to the _Data Panopticon_ by providing a number of
RESTfull endpoints.

See [development.md]() for details on running Eris in dev.

## Running

Eris requires a Neo4j instance to run and a valid configuration, which can be
provided via a config file, environment variables, command line arguments, or
a mixture of all three. Command line arguments have the highest precedence, then
environment variables, then the configuration file. [config-default.json]() is a
complete configuration file set to the default values for each config item.

To see a list of valid arguments use `eris -h`.

Run Eris using `eris <arguments>`, and is typically run using:

```
eris -c /path/to/config.json
```

## Root Passphrase

The root passphrase option sets or rests the passphrase for the `root` user in
the data panopticon. It _must_ be set the first time Eris runs against an
instance of Neo4j. To avoid having the passphrase on the command line use
`ERIS_ROOT_PASSPHRASE`. The root passphrase cannot be set via configuration
file.

> Note: This passphrase is distinct to the password used to log into Neo4j.

## API Secret

Eris uses a _secret_ when generating tokens to access its API. If there is no
secret provided in the Eris configuration then a random secret will be used. To
allow an API token to be valid across Eris restarts, or across multiple,
clustered instances of Eris a common secret must be provided. All existing
tokens can be invalidated by changing the secret and restarting Eris.

## Connecting to Neo4j

Eris connects to Neo4j using the Bolt protocol and requires the URL for the
database instance (typically `bolt://hostname:7687`), database user (typically 
`neo4j`), and the password that has been set for that user.

TLS is disabled by default for the connection and must be specified in the 
configuration. This is because TLS needs to be specifically configured for 
Neo4j. To avoid accidentally connecting without TLS it is advised to set TLS to
always required in the Neo4j configuration.

Eris starts up much faster than Neo4j. To allow for this it will retry the
connection a number of times with an increasing backoff between attempts. The 
number of retries can be configured if startup times are considerably longer.

A complete Neo4j configuration would look like:

```json
{
  "bolt-url": "bolt://hostname:7687",
  "bolt-user": "neo4j",
  "bolt-password": "password set for neo4j user on DB setup",
  "bolt-tls": true,
  "bolt-retries": 5
}
```

## Logging

The default Eris logger reports to `STDOUT`. This can be changed by configuring
one or more of the custom loggers which can be configured to log to console (via
`STDOUT` or `STDERR`), file, and/or syslog.

To enable a logger set the relevant format setting for that logger to either
`text` or `json`.

* `console-format` enables the custom console logger
* `log-format` enables logging to file
* `syslog-format` enables logging via syslog

Each log type has additional configuration options to provide control over the
log output, and different formats can be used for different loggers.

> Note: Enabling any of the custom loggers will disable the default logger.
> To continue with console logging with the file or syslog loggers enabled the 
> console logger will need to be explicitly enabled.

## TLS

The TLS settings (`tls-key` and `tls-certificate`) are used to configure TLS 
for the Eris API. These point to the keyfile and certificate files Eris should
use for TLS.

> Note: These settings control TLS use on the Eris API. To enable TLS between
> Eris and Neo4j use `bolt-tls`.

## Watchers

Watchers can be to look for, and process data files. Watchers can be configured
via a separate JSON file specified by the `--watchers` flag (`$ERIS_WATCHERS`,
or the `watchers` entry in the config file can also be used). The file is a JSON
list of watchers. `watchers-example.json` gives a simple example configuration.

A watcher is defined
using:

```json
{
  "Model": "name of Eris model to load data into",
  "Source": "name of source defined in Eris",
  "Mapping": "name of mapping defined in Eris",
  "User": "user to load the data as",
  "Input":"path to directory where data will be dumped",
  "DataType": "csv",
  "Strip": 0,
  "Archive": "path to directory where processed files will be moved to",
  "Interval": 60
}
```

`Strip` is the number of lines to strip from the head of the file.

`Interval` is the time, in seconds, between checks of the `Input` directory for
new data.

Currently, the only `DataType` supported is `csv`.

> Note: Only a single instance of Eris should be configured to watch any given
input directory.
