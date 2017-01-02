## v1.0.0 (2017-01-02)

Features:

- Complete re-write of internals for easier maintenance
- Support for all different RPC versions
- Support for all RPC methods

## v0.4.0 (2015-05-09)

Features:

- Added `set_location` method to torrent model (thanks @balinez)

## v0.3.1 (2015-04-03)

Bugfixes:

- `uninitialized constant Transmission::Model::SessionStats` error fix

## v0.3.0 (2015-04-02)

Features:

- ability to handle multiple torrents in one instance
- `start_all!` & `stop_all!` static class methods for torrents
- `reload!`, `to_json`, `is_multi?`, `is_finished` instance method for torrents
- `to_json` instance method for session & session stats

## v0.2.1 (2015-04-01)

Bugfixes:

- when adding torrents the returned torrent instance will use same options for finding added torrent

## v0.2.0 (2015-03-31)

Features:

- all basic torrent actions (start, stop, move up queue, etc)
- session model
- session stats model
- adding torrents

## v0.1.0 (2015-03-12)

- Initial project import
