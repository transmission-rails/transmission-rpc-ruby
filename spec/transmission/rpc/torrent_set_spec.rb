require 'pp'

describe Transmission::RPC::TorrentSet do

  describe '#new' do

    before :each do
      # @torrent_get = Transmission::RPC::TorrentGet.new({ ids: [], fields: ['ids'] }, 15)
      @rpc = Transmission::RPC.new
    end

    it 'should' do
      # @torrent_get.validate
      # puts @torrent_get.errors
      # puts @torrent_get.to_arguments
      # puts @torrent_get.build_response({torrents: [{id: 1}]})
      # puts JSON.pretty_generate(Transmission::RPC::TorrentGet.response.structure(14))
      puts @rpc.torrent_get('recently-active', ['ids'])
    end

  end

end
