module Transmission
  class Arguments
    class SessionSet < Transmission::Arguments

      ATTRIBUTES = [
          'alt-speed-down',
          'alt-speed-enabled',
          'alt-speed-time-begin',
          'alt-speed-time-enabled',
          'alt-speed-time-end',
          'alt-speed-time-day',
          'alt-speed-up',
          'blocklist-url',
          'blocklist-update',
          'blocklist-enabled',
          'cache-size-mb',
          'download-dir',
          'download-queue-size',
          'download-queue-enabled',
          'dht-enabled',
          'encryption',
          'required',
          'preferred',
          'tolerated',
          'idle-seeding-limit',
          'idle-seeding-limit-enabled',
          'incomplete-dir',
          'incomplete-dir-enabled',
          'lpd-enabled',
          'peer-limit-global',
          'peer-limit-per-torrent',
          'pex-enabled',
          'peer-port',
          'peer-port-random-on-start',
          'port-forwarding-enabled',
          'queue-stalled-enabled',
          'queue-stalled-minutes',
          'rename-partial-files',
          'script-torrent-done-filename',
          'script-torrent-done-enabled',
          'done',
          'seedRatioLimit',
          'seedRatioLimited',
          'seed-queue-size',
          'seed-queue-enabled',
          'speed-limit-down',
          'speed-limit-down-enabled',
          'speed-limit-up',
          'speed-limit-up-enabled',
          'start-added-torrents',
          'trash-original-torrent-files',
          'units',
          'utp-enabled'
      ]

    end
  end
end