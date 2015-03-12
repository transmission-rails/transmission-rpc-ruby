# Transmission RPC

First primitive version.

There is a couple of these RPC wrappers around already, but I am looking for a nice object oriented solution.

Main aim for this project => Object Oriented solution for Transmission RPC connection.

## Examples (Currently working)
### Finding a torrent

    torrent = Transmission::Model::Torrent.find 1

### Getting all torrents

    torrents = Transmission::Model::Torrent.all

### Adding a torrent

    torrent = Transmission::Model::Torrent.add filename: 'http://example.com/some_torrent.torrent'
    # or
    torrent = Transmission::Model::Torrent.add filename: 'magnet_link'

### Deleting a torrent

    torrent = Transmission::Model::Torrent.find 1
    # Deletes torrents
    torrent.delete!
    # Deletes torrent and local data
    torrent.delete! true

## Examples (Currently NOT working but desired)

### Torrent instance methods

    torrent = Transmission::Model::Torrent.find 1
    torrent.move_up
    torrent.move_down
    torrent.move_top
    torrent.move_bottom
    torrent.start
    torrent.start_now
    torrent.stop
    torrent.verify
    torrent.re_announce
    torrent.finished?
    torrent.to_json

### This project is still WIP!!