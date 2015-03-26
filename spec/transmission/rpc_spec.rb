describe Transmission::RPC do

  describe '#set_session' do

    before :each do
      stub_session_get
      stub_session_stats
      @rpc = Transmission::RPC.new host: 'localhost', port: 9091, ssl: false
      stub_request(:post, 'http://localhost:9091/transmission/rpc')
          .with(:body => {:method => 'session-set', :arguments => {a: 'a', b: 'b'}})
          .to_return(:status => 200, body: {result: 'success'}.to_json)
    end

    it 'should send the proper arguments' do
      @rpc.set_session a: 'a', b: 'b'
      expect(@rpc.connector.response.status).to eq(200)
    end

    it 'should send the proper method' do
      @rpc.set_session a: 'a', b: 'b'
      expect(@rpc.connector.response.status).to eq(200)
    end

  end

end