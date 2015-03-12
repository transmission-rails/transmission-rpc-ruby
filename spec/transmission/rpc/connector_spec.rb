describe Transmission::RPC::Connector do

  describe '#new' do

    describe 'without parameters' do
      before :each do
        @connector = Transmission::RPC::Connector.new
      end

      it 'should create an RPC object with default values' do
        expect(@connector.host).to eq('localhost')
        expect(@connector.port).to eq(9091)
        expect(@connector.ssl).to eq(false)
      end
    end

    describe 'with parameters' do
      before :each do
        @connector = Transmission::RPC::Connector.new 'some.host', 8888, true
      end

      it 'should create an RPC object with given parameters' do
        expect(@connector.host).to eq('some.host')
        expect(@connector.port).to eq(8888)
        expect(@connector.ssl).to eq(true)
      end
    end

  end

  describe '#post' do

    describe 'when session ID has not been acquired yet' do
      before :each do
        @connector = Transmission::RPC::Connector.new 'localhost'
        stub_rpc status: 409, body: '', headers: {'x-transmission-session-id' => 'abc'}
      end

      it 'should save the transmission session ID' do
        @connector.post
        expect(@connector.session_id).to eq('abc')
      end
    end

    describe 'when session ID has been acquired' do
      before :each do
        @connector = Transmission::RPC::Connector.new 'localhost'
        stub_rpc status: 200
      end

      it 'should respond successfully' do
        response = @connector.post
        expect(response.status).to eq(200)
      end
    end

    describe 'when basic auth is required but no credentials provided' do
      before :each do
        @connector = Transmission::RPC::Connector.new 'localhost'
        stub_rpc status: 401
      end

      it 'should indicate auth error' do
        @connector.post
        expect(@connector.auth_error).to eq(true)
      end
    end

  end

end