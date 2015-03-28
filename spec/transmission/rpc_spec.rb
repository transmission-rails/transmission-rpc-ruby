describe Transmission::RPC do

  describe '#get_session' do

    describe 'with fields' do

      before :each do
        @rpc = Transmission::RPC.new
        fields = Transmission::Fields::SessionGet.new(['version']).to_fields
        stub_rpc_request
            .with({body: session_get_body({fields: fields})})
            .to_return(successful_response)
      end

      it 'should send the proper arguments' do
        @rpc.get_session fields: ['version']
        expect(@rpc.connector.response.status).to eq(200)
      end

    end

    describe 'without fields' do

      before :each do
        @rpc = Transmission::RPC.new
        fields = Transmission::Fields::SessionGet.new.to_fields
        stub_rpc_request
            .with({body: session_get_body({fields: fields})})
            .to_return(successful_response)
      end

      it 'should send the proper arguments' do
        @rpc.get_session
        expect(@rpc.connector.response.status).to eq(200)
      end

    end

  end

end