module Transmission
  class RPC
    class TorrentGet < Method

      mutator 'ids', validate: :validate_ids
      mutator 'fields', type: Array

      field 'activityDate'
      field 'addedDate'
      field 'bandwidthPriority'
      field 'comment'
      field 'corruptEver'
      field 'creator'
      field 'dateCreated'
      field 'desiredAvailable'
      field 'doneDate'
      field 'downloadDir'
      field 'downloadedEver'
      field 'downloadLimit'
      field 'downloadLimited'
      field 'error'
      field 'errorString'
      field 'eta'
      field 'etaIdle'
      field 'files'
      field 'fileStats'
      field 'hashString'
      field 'haveUnchecked'
      field 'haveValid'
      field 'honorsSessionLimits'
      field 'id'
      field 'isFinished'
      field 'isPrivate'
      field 'isStalled'
      field 'leftUntilDone'
      field 'magnetLink'
      field 'manualAnnounceTime'
      field 'maxConnectedPeers'
      field 'metadataPercentComplete'
      field 'name'
      field 'peer-limit'
      field 'peers'
      field 'peersConnected'
      field 'peersFrom'
      field 'peersGettingFromUs'
      field 'peersSendingToUs'
      field 'percentDone'
      field 'pieces'
      field 'pieceCount'
      field 'pieceSize'
      field 'priorities'
      field 'queuePosition'
      field 'rateDownload (B/s)'
      field 'rateUpload (B/s)'
      field 'recheckProgress'
      field 'secondsDownloading'
      field 'secondsSeeding'
      field 'seedIdleLimit'
      field 'seedIdleMode'
      field 'seedRatioLimit'
      field 'seedRatioMode'
      field 'sizeWhenDone'
      field 'startDate'
      field 'status'
      field 'trackers'
      field 'trackerStats'
      field 'totalSize'
      field 'torrentFile'
      field 'uploadedEver'
      field 'uploadLimit'
      field 'uploadLimited'
      field 'uploadRatio'
      field 'wanted'
      field 'webseeds'
      field 'webseedsSendingToUs'

      response do |r|
        r.array :torrents do |r|
          r.field 'activityDate', type: Integer
          r.field 'id', type: Integer
          # ...

          r.array 'files' do |r|
            r.field 'bytesCompleted', type: Integer
            r.field 'length', type: Integer
            r.field 'name', type: String
          end

          r.object 'peersFrom' do |r|
            r.field 'fromCache', type: Integer
          end
        end
      end

      private

      def validate_ids(mutator)
        if !mutator.value.is_a?(Array) && (mutator.value.is_a?(String) && mutator.value != 'recently-active')
          yield("#{mutator.key} mutator needs to be an array of IDs or 'recently-active'")
        end
      end

    end
  end
end
