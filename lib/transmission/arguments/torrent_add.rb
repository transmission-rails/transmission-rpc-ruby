module Transmission
  class Arguments
    class TorrentAdd < Transmission::Arguments

      ATTRIBUTES = [
          {field: 'cookies'},
          {field: 'download-dir'},
          {field: 'filename'},
          {field: 'metainfo'},
          {field: 'paused'},
          {field: 'peer-limit'},
          {field: 'bandwidthPriority'},
          {field: 'files-wanted'},
          {field: 'files-unwanted'},
          {field: 'priority-high'},
          {field: 'priority-low'},
          {field: 'priority-normal'}
      ]

      REQUIRED = [
          'filename metainfo'
      ]

    end
  end
end