describe Transmission::Model::Torrent do

  describe '.all' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_get_torrent({}, [{id: 1}])
      end

      it 'should return a Torrent model instance' do
        torrents = Transmission::Model::Torrent.all
        expect(torrents).to be_a(Transmission::Model::Torrent)
      end
    end

    describe 'with connector' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_rpc_request
            .with(body: torrent_get_body)
            .to_return(successful_response({arguments: {torrents: [{id: 1}]}}))
      end

      it 'should return a Torrent model instance' do
        torrents = Transmission::Model::Torrent.all connector: @rpc
        expect(torrents).to be_a(Transmission::Model::Torrent)
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

    describe 'with multiple ids' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_torrent({ids: [1, 2]}, [{id: 1}, {id: 2}])
      end

      it 'should return a Torrent model instance' do
        torrent = Transmission::Model::Torrent.find [1, 2], connector: @rpc
        expect(torrent).to be_a(Transmission::Model::Torrent)
      end

      it 'should remember all ids' do
        torrent = Transmission::Model::Torrent.find [1, 2], connector: @rpc
        expect(torrent.ids).to eq([1, 2])
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

    describe 'with multiple ids' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_torrent({ids: [1, 2]}, [{id: 1}, {id: 2}])
        stub_rpc_request
            .with(body: torrent_remove_body({:ids => [1, 2], 'delete-local-data' => false}))
            .to_return(successful_response({arguments: {torrents: [{id: 1}, {id: 2}]}}))
      end

      it 'should remove the torrent files' do
        torrent = Transmission::Model::Torrent.find [1, 2], :connector => @rpc
        torrent.delete!
        expect(torrent.deleted).to eq(true)
      end
    end

  end

  describe '#is_multi?' do
    let(:torrents) { Transmission::Model::Torrent.new([{'id' => 1}, {'id' => 2}], nil) }
    let(:torrent) { Transmission::Model::Torrent.new([{'id' => 1}], nil) }

    describe 'with multiple torrents' do
      it 'should return true' do
        expect(torrents.is_multi?).to eq(true)
      end
    end

    describe 'with single torrent' do
      it 'should return false' do
        expect(torrent.is_multi?).to eq(false)
      end
    end
  end

  describe '#to_json' do
    let(:torrents) { Transmission::Model::Torrent.new([{'id' => 1}, {'id' => 2}], nil) }
    let(:torrent) { Transmission::Model::Torrent.new([{'id' => 1}], nil) }

    describe 'with multiple torrents' do
      it 'should return true' do
        expect(torrents.to_json).to eq([{'id' => 1}, {'id' => 2}])
      end
    end

    describe 'with single torrent' do
      it 'should return false' do
        expect(torrent.to_json).to eq({'id' => 1})
      end
    end
  end

  describe '#method_missing' do
    let(:torrent) { Transmission::Model::Torrent.new([{'id' => 1, 'name' => 'some name', 'some-key' => 'some-value'}], nil) }

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

  describe '#save!' do
    let(:rpc) {Transmission::RPC.new}

    before :each do
      stub_const("Transmission::Arguments::TorrentSet::ATTRIBUTES", [{field: 'name'}, {field: 'ids'}])
      stub_get_torrent({ids: [1]}, [{id: 1, name: 'test', comment: 'comment'}])
      stub_rpc_request
          .with(body: torrent_set_body({name: 'new value', ids: [1]}))
          .to_return(successful_response)
    end

    it 'should send the right parameters' do
      torrent = Transmission::Model::Torrent.find 1, connector: rpc
      torrent.name = 'new value'
      torrent.save!
    end
  end

  [
      {method: 'start!', rpc_method: 'torrent-start'},
      {method: 'start_now!', rpc_method: 'torrent-start-now'},
      {method: 'stop!', rpc_method: 'torrent-stop'},
      {method: 'verify!', rpc_method: 'torrent-verify'},
      {method: 're_announce!', rpc_method: 'torrent-reannounce'},
      {method: 'move_up!', rpc_method: 'queue-move-up'},
      {method: 'move_down!', rpc_method: 'queue-move-down'},
      {method: 'move_top!', rpc_method: 'queue-move-top'},
      {method: 'move_bottom!', rpc_method: 'queue-move-bottom'}
  ].each do |object|
    describe "##{object[:method]}" do
      let(:rpc) {Transmission::RPC.new}

      [
          {ids: [1], response: [{id: 1}], text: ''},
          {ids: [1, 2], response: [{id: 1}, {id: 2}], text: 'with multiple ids'}
      ].each do |args|
        before :each do
          stub_get_torrent({ids: args[:ids]}, args[:response])
          stub_rpc_request
              .with(body: torrent_method_body(object[:rpc_method], {ids: args[:ids]}))
              .to_return(successful_response)
        end

        it "should #{object[:method]} torrent #{args[:text]}" do
          torrent = Transmission::Model::Torrent.find args[:ids], connector: rpc
          torrent.send object[:method].to_sym
        end
      end
    end
  end

end