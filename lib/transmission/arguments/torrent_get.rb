module Transmission
  class Arguments
    class TorrentGet

      ATTRIBUTES = [
          'id',
          'activityDate',
          'addedDate',
          'bandwidthPriority',
          'comment',
          'corruptEver',
          'creator',
          'dateCreated',
          'desiredAvailable',
          'doneDate',
          'downloadDir',
          'downloadedEver',
          'downloadLimit',
          'downloadLimited',
          'error',
          'errorString',
          'eta',
          'etaIdle',
          'files',
          'fileStats',
          'hashString',
          'haveUnchecked',
          'haveValid',
          'honorsSessionLimits',
          'isFinished',
          'isPrivate',
          'isStalled',
          'leftUntilDone',
          'magnetLink',
          'manualAnnounceTime',
          'maxConnectedPeers',
          'metadataPercentComplete',
          'name',
          'peer-limit',
          'peers',
          'peersConnected',
          'peersFrom',
          'peersGettingFromUs',
          'peersSendingToUs',
          'percentDone',
          'pieces',
          'pieceCount',
          'pieceSize',
          'priorities',
          'queuePosition',
          'rateDownload',
          'rateUpload',
          'recheckProgress',
          'secondsDownloading',
          'secondsSeeding',
          'seedIdleLimit',
          'seedIdleMode',
          'seedRatioLimit',
          'seedRatioMode',
          'sizeWhenDone',
          'startDate',
          'status',
          'trackers',
          'trackerStats',
          'totalSize',
          'torrentFile',
          'uploadedEver',
          'uploadLimit',
          'uploadLimited',
          'uploadRatio',
          'wanted',
          'webseeds',
          'webseedsSendingToUs'
      ]

      attr_accessor :arguments

      def initialize(arguments = nil)
        @arguments = arguments.inject([]) do |attributes, attribute|
          raise Transmission::Arguments::InvalidArgument unless ATTRIBUTES.include? attribute
          attributes << attribute
        end if arguments
        @arguments = ATTRIBUTES if arguments.nil?
      end

      def to_arguments
        @arguments
      end

    end
  end
end