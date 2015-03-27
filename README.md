# Transmission RPC Ruby

First primitive version.

There is a couple of these RPC wrappers around already, but I am looking for a nice object oriented solution.

Main aim for this project => Object Oriented solution for Transmission RPC connection.

This Project follows the RPC spec for transmission under `https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt` and is planning on supporting release version >= 2.40 and RPC version >= 14

## Examples (Currently working)

To use the `Model` classes you need to set up some configs first

    Transmission::Config.set host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

Now all models will use the globally set configs

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

### Dealing with fields

To limit the amount of fields sent around you can limit the information by passing an array of desired fields

    torrent = Transmission::Model::Torrent.all fields: ['id']

### Using different connectors

If you are planning on using this lib to connect to multiple transmission daemon instances you can pass your own `Transmission::RPC` instance

    connector = Transmission::RPC.new host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}
    torrents = Transmission::Model::Torrent.all connector: connector

### Find out Transmission & RPC version

    connector = Transmission::RPC.new host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}
    session = connector.session
    session.rpc_version          #=> 14
    session.version              #=> "2.52"

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