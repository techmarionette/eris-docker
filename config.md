# Eris Configuration Settings

Eris can be configured through a variety of methods to allow for flexibility. 
Base config is normally provided through a JSON config file. Overrides for this
can be set in environment variables. Finally, command line arguments can be 
passed to Eris which take precedence over everything. Details for the settings
can be found using `eris -h` or `eris --help`.

> Note: `-h`, `-c`, and `-p` have no equivalent config file setting.

Eris is configured via a JSON configuration file. The file 
[config-defaults.json](./config-defaults.json) contains an example set of 
configuration options and their default values. This file explains their 
purpose.

## Watchers

Watchers can be to look for, and process data files. Watchers are configured via
a separate JSON file specified by the `--watchers` flag (`$ERIS_WATCHERS`, or
the `watchers` entry in the config file can also be used). The file is a JSON
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
