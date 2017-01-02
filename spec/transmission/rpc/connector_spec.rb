describe Transmission::RPC::Connector do

  it '#new without parameters should create an RPC object with default values' do
    connector = Transmission::RPC::Connector.new

    expect(connector.host).to eq('localhost')
    expect(connector.port).to eq(9091)
    expect(connector.ssl).to eq(false)
    expect(connector.path).to eq('/transmission/rpc')
    expect(connector.credentials).to eq(nil)
    expect(connector.rpc_version).to eq(15)
  end

  it '#new with parameters should create an RPC object with given parameters' do
    connector = Transmission::RPC::Connector.new(host: 'some.host', port: 8888, ssl: true, path: '/path', rpc_version: 14, credentials: { username: 'a', password: 'b' })

    expect(connector.host).to eq('some.host')
    expect(connector.port).to eq(8888)
    expect(connector.ssl).to eq(true)
    expect(connector.path).to eq('/path')
    expect(connector.credentials).to eq(username: 'a', password: 'b')
    expect(connector.rpc_version).to eq(14)
  end

end
