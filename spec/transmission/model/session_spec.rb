describe Transmission::Model::Session do

  describe '.get' do

    describe 'with configuration' do
      before :each do
        Transmission::Config.set
        stub_get_session(Transmission::Fields::SessionGet.new.to_fields)
      end

      it 'should return a session model' do
        session = Transmission::Model::Session.get
        expect(session).to be_a(Transmission::Model::Session)
      end
    end

    describe 'with connector' do
      before :each do
        @rpc = Transmission::RPC.new
        stub_get_session(Transmission::Fields::SessionGet.new.to_fields)
      end

      it 'should return an array of Torrent models' do
        session = Transmission::Model::Session.get connector: @rpc
        expect(session).to be_a(Transmission::Model::Session)
      end
    end
  end

  describe '#save!' do
    let(:rpc) {Transmission::RPC.new}

    before :each do
      stub_const("Transmission::Arguments::SessionSet::ATTRIBUTES", [{field: 'name'}])
      stub_get_session(Transmission::Fields::SessionGet.new.to_fields)
      stub_rpc_request
          .with(body: session_set_body({name: 'new value'}))
          .to_return(successful_response)
    end

    it 'should send the right parameters' do
      session = Transmission::Model::Session.get connector: rpc
      session.name = 'new value'
      session.save!
    end
  end

  describe '#method_missing' do
    let(:session) { Transmission::Model::Session.new({'id' => 1, 'name' => 'some name', 'some-key' => 'some-value'}, nil) }

    before :each do
      stub_const("Transmission::Fields::SessionGet::ATTRIBUTES", [{field: 'id'}, {field: 'name'}, {field: 'some-key'}])
      stub_const("Transmission::Arguments::SessionSet::ATTRIBUTES", [{field: 'name'}])
    end

    describe 'with existing attributes' do
      it 'should return the correct values' do
        expect(session.id).to eq(1)
        expect(session.name).to eq('some name')
        expect(session.some_key).to eq('some-value')
      end

      it 'should set the correct values' do
        session.name = 'ok'
        expect(session.name).to eq('ok')
      end
    end

    describe 'with none existing attributes' do
      it 'should raise error' do
        expect {
          session.i_dont_exist
        }.to raise_error(NoMethodError)
      end

      it 'should raise error' do
        expect {
          session.i_dont_exist = 'some value'
        }.to raise_error(NoMethodError)
      end
    end
  end

end