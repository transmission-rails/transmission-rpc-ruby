# Transmission RPC Ruby

[![Build Status](https://travis-ci.org/transmission-rails/transmission-rpc-ruby.svg?branch=master)](https://travis-ci.org/transmission-rails/transmission-rpc-ruby) [![Code Climate](https://codeclimate.com/github/transmission-rails/transmission-rpc-ruby/badges/gpa.svg)](https://codeclimate.com/github/transmission-rails/transmission-rpc-ruby) [![Dependency Status](https://gemnasium.com/transmission-rails/transmission-rpc-ruby.svg)](https://gemnasium.com/transmission-rails/transmission-rpc-ruby) [![Coverage Status](https://coveralls.io/repos/transmission-rails/transmission-rpc-ruby/badge.svg?branch=master)](https://coveralls.io/r/transmission-rails/transmission-rpc-ruby?branch=master)


### This project is still WIP!!

First primitive version.

There is a couple of these RPC wrappers around already, but I am looking for a nice object oriented solution.

Main aim for this project => Object Oriented solution for Transmission RPC connection.

This Project follows the RPC spec for transmission under `https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt` and is planning on supporting release version >= 2.40 and RPC version >= 14

## Installation

    gem install transmission-rpc-ruby

Then require it

    require 'transmission'


## Examples (Currently working)

To use the `Model` classes you need to set up some configs first

    Transmission::Config.set host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

Now all models will use the globally set configs

__NOTE:__ The first time you call any of the class or instance methods of `Transmission::Model` or in fact the rpc connector without providing a valid session ID the request will fail

    torrent = Transmission::Model::Torrent.find 1
    # => Transmission::RPC::Connector::InvalidSessionError: Transmission::RPC::Connector::InvalidSessionError

The second time around it will remember the session ID returned by the last attempt.

    torrent = Transmission::Model::Torrent.find 1
    # => Transmission::Model::Torrent

Better solution would be to remember the session id and use it later again.

    rpc = Transmission::Model::Torrent.connector
    session_id = rpc.connector.session_id

    # Later

    Transmission::Config.set host: 'some.host', port: 9091, ssl: false, session_id: 'xxxx', credentials: {username: 'transmission', password: '********'}


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
    session = Transmission::Model::Session.get connector: connector
    session.rpc_version
    session.version

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