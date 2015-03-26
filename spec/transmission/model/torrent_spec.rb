describe Transmission::Model::Torrent do

  describe '.all' do

    before :each do
      stub_session_get
      stub_session_stats
      Transmission::Config.set host: 'localhost', port: 9091, ssl: false
      stub_torrent_get_all
    end

    it 'should return an array of Torrent models' do
      torrents = Transmission::Model::Torrent.all
      expect(torrents).to be_an(Array)
      expect(torrents.first).to be_a(Transmission::Model::Torrent)
    end

  end

  describe '.find' do

    before :each do
      stub_session_get
      stub_session_stats
      Transmission::Config.set host: 'localhost', port: 9091, ssl: false
      stub_torrent_get_single
    end

    it 'should return a Torrent instance' do
      torrent = Transmission::Model::Torrent.find 1
      expect(torrent).to be_a(Transmission::Model::Torrent)
    end

  end

  describe '.add' do

    describe 'when filename is provided' do

      before :each do
        stub_session_get
        stub_session_stats
        Transmission::Config.set host: 'localhost', port: 9091, ssl: false
        stub_torrent_add filename: 'torrent_file'
        stub_torrent_get_single
      end



    end

    describe 'when filename is not provided' do

      before :each do
        stub_session_get
        stub_session_stats
        Transmission::Config.set host: 'localhost', port: 9091, ssl: false
        stub_torrent_add filename: 'torrent_file'
        stub_torrent_get_single
      end

      xit 'should return a Torrent instance' do
        expect { Transmission::Model::Torrent.add }.to raise_error(Transmission::Model::Torrent::MissingAttributesError)
      end

    end

    describe 'when torrent already exists / is a duplicate' do

    end

  end

  describe '#delete!' do

    before :each do
      stub_session_get
      stub_session_stats
      Transmission::Config.set host: 'localhost', port: 9091, ssl: false
      stub_torrent_get_single
      stub_torrent_remove
    end

    it 'should remove the torrent file' do
      torrent = Transmission::Model::Torrent.find 1
      torrent.delete!
      expect(torrent.deleted).to eq(true)
    end

  end

end