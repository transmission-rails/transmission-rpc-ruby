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