module Stubs

  def stub_torrent_get_all
    stub_request(:post, 'http://localhost:9091/transmission/rpc')
        .with(:body => {:method => 'torrent-get', :arguments => {fields: Transmission::Arguments::TorrentGet::ATTRIBUTES}})
        .to_return(:status => 200, :body => {arguments: {torrents: [{id: 1}]}, result: 'success'}.to_json)
  end

  def stub_torrent_get_single
    stub_request(:post, 'http://localhost:9091/transmission/rpc')
        .with(:body => {:method => 'torrent-get', :arguments => {ids: [1], fields: Transmission::Arguments::TorrentGet::ATTRIBUTES}})
        .to_return(:status => 200, :body => {arguments: {torrents: [{id: 1}]}, result: 'success'}.to_json)
  end

  def stub_torrent_add(options = {})
    stub_request(:post, 'http://localhost:9091/transmission/rpc')
        .with(:body => {:method => 'torrent-add', :arguments => {filename: options[:filename]}})
        .to_return(:status => 200, :body => {arguments: {'torrent-added' => {id: 1}}, result: 'success'}.to_json)
  end

  def stub_torrent_remove(local_data = false)
    stub_request(:post, 'http://localhost:9091/transmission/rpc')
        .with(:body => {:method => 'torrent-remove', :arguments => {:ids => [1], 'delete-local-data' => local_data}})
        .to_return(:status => 200, :body => {result: 'success'}.to_json)
  end

  def stub_rpc(options = {})
    stub_request(:post, 'http://localhost:9091/transmission/rpc')
        .to_return(:status => options[:status], :body => options[:body], :headers => options[:headers])
  end

end