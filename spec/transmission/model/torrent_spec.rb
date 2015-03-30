describe Transmission::Model::Torrent do

  describe '.all' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_get_torrent({}, [{id: 1}])
      end

      it 'should return an array of Torrent models' do
        torrents = Transmission::Model::Torrent.all
        expect(torrents).to be_an(Array)
        expect(torrents.first).to be_a(Transmission::Model::Torrent)
      end
    end

    describe 'with connector' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_rpc_request
            .with(body: torrent_get_body)
            .to_return(successful_response({arguments: {torrents: [{id: 1}]}}))
      end

      it 'should return an array of Torrent models' do
        torrents = Transmission::Model::Torrent.all connector: @rpc
        expect(torrents).to be_an(Array)
        expect(torrents.first).to be_a(Transmission::Model::Torrent)
      end
    end

  end

  describe '.find' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_get_torrent({ids: [1]}, [{id: 1}])
      end

      it 'should return a Torrent instance' do
        torrent = Transmission::Model::Torrent.find 1
        expect(torrent).to be_a(Transmission::Model::Torrent)
      end
    end

    describe 'with connector' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_torrent({ids: [1]}, [{id: 1}])
      end

      it 'should return a Torrent instance' do
        torrent = Transmission::Model::Torrent.find 1, connector: @rpc
        expect(torrent).to be_a(Transmission::Model::Torrent)
      end
    end

    describe 'with invalid id' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_torrent({ids: [1]}, [])
      end

      it 'should raise error' do
        expect {
          Transmission::Model::Torrent.find 1, connector: @rpc
        }.to raise_error(Transmission::Model::Torrent::TorrentNotFoundError)
      end
    end

  end

  describe '.add' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_rpc_request
            .with(body: torrent_add_body({filename: 'torrent_file'}))
            .to_return(successful_response({arguments: {'torrent-added' => {id: 1}}}))
        stub_get_torrent({ids: [1]}, [{id: 1}])
      end

      it 'should return a Torrent instance' do
        torrent = Transmission::Model::Torrent.add arguments: {filename: 'torrent_file'}
        expect(torrent).to be_a(Transmission::Model::Torrent)
      end
    end

    describe 'when torrent is a duplicate' do
      before :each do
        Transmission::Config.set
        stub_rpc_request
            .with(body: torrent_add_body({filename: 'torrent_file'}))
            .to_return(unsuccessful_response({result: 'duplicate torrent'}))
      end

      it 'should raise error' do
        expect {
          Transmission::Model::Torrent.add arguments: {filename: 'torrent_file'}
        }.to raise_error(Transmission::RPC::Connector::ConnectionError)
      end
    end

  end

  describe '#delete!' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_get_torrent({ids: [1]}, [{id: 1}])
        stub_rpc_request
            .with(body: torrent_remove_body({:ids => [1], 'delete-local-data' => false}))
            .to_return(successful_response({arguments: {torrents: [{id: 1}]}}))
      end

      it 'should remove the torrent file' do
        torrent = Transmission::Model::Torrent.find 1
        torrent.delete!
        expect(torrent.deleted).to eq(true)
      end
    end

    describe 'with connector' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_torrent({ids: [1]}, [{id: 1}])
        stub_rpc_request
            .with(body: torrent_remove_body({:ids => [1], 'delete-local-data' => false}))
            .to_return(successful_response({arguments: {torrents: [{id: 1}]}}))
      end

      it 'should remove the torrent file' do
        torrent = Transmission::Model::Torrent.find 1, :connector => @rpc
        torrent.delete!
        expect(torrent.deleted).to eq(true)
      end
    end

  end

  describe '#method_missing' do
    let(:torrent) { Transmission::Model::Torrent.new({'id' => 1, 'name' => 'some name', 'some-key' => 'some-value'}) }

    before :each do
      stub_const("Transmission::Fields::TorrentGet::ATTRIBUTES", [{field: 'id'}, {field: 'name'}, {field: 'some-key'}])
      stub_const("Transmission::Arguments::TorrentSet::ATTRIBUTES", [{field: 'name'}])
    end

    describe 'with existing attributes' do
      it 'should return the correct values' do
        expect(torrent.id).to eq(1)
        expect(torrent.name).to eq('some name')
        expect(torrent.some_key).to eq('some-value')
      end

      it 'should set the correct values' do
        torrent.name = 'ok'
        expect(torrent.name).to eq('ok')
      end
    end

    describe 'with none existing attributes' do
      it 'should raise error' do
        expect {
          torrent.i_dont_exist
        }.to raise_error(NoMethodError)
      end

      it 'should raise error' do
        expect {
          torrent.i_dont_exist = 'some value'
        }.to raise_error(NoMethodError)
      end
    end
  end

end