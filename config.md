# Eris Configuration Settings

Eris is configured via a JSON configuration file. The file 
[config-defaults.json](./config-defaults.json) contains an example set of 
configuration options and their default values. This file explains their 
purpose.

## Server Section

### Port

Defines the port Eris will run on. This defaults to `8080`.

## TLS Section

### Key

Path to the TLS Key. When set with `Certificate` Eris will use TLS for all
inbound connections.

### Certificate

Path to the TLS Certificate. When set with `Key` Eris will use TLS for all
inbound connections.

## Store Section

### BoltURL

URL to connect to Neo4j via bolt. This is generally: `bolt://<db hostname>:7687`
and defaults to trying to connect via localhost.

### Username

The Neo4j username.

### Password

The Neo4j password. This can also be set using the `--neo4j_password` flag.

### TLS

Boolean used to set TLS for the bolt protocol. If set to `true` then the Neo4j
instance will need to be configured for TLS.

## Security Section

### Secret

Secret used when generating Bearer tokens. By default this is a random key set
on startup, but can be set in the configuration, or via the `-s` flag to allow
concurrent instances of eris to service requests.

## Log Section

### JSON

Be default Eris logs using plain text. This will change the logger to output
messages in JSON format.

### Local

If set Eris will log to this file, otherwise it logs to `stdout`.

> Note: Eris doesn't implement log rotation. This should be done by something
like `logrotate(8)`.

### Remote

Remote syslog host. If configured Eris will connect via UDP and forward log
messages to the remote log service.

## Watchers Section

Watchers can be to look for, and process data files. A watcher is defined
using:

```json
{
  "Model": "name of Eris model to load data into",
  "Source": "name of source defined in Eris",
  "Mapping": "name of mapping defined in Eris",
  "User": "user to load the data as",
  "Input":"path to directory where data will be dumped",
  "DataType": "csv",
  "Archive": "path to directory where processed files will be moved to",
  "Interval": 60
}
```

`Interval` is the time, in seconds, between checks of the `Input` directory for
new data.

Currently, the only `DataType` supported is `csv`.

> Note: Only a single instance of Eris should be configured to watch any given
input directory.
