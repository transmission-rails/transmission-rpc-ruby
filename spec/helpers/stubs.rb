module Stubs

  def stub_rpc_request(options = {})
    host = options[:host] || 'localhost'
    port = options[:port] || 9091
    path = options[:path] || '/transmission/rpc'
    scheme  = !!options[:ssl] ? 'https' : 'http'
    stub_request(:post, "#{scheme}://#{host}:#{port}#{path}")
  end

  def stub_get_torrent(body, torrents)
    stub_rpc_request
        .with(body: torrent_get_body(body))
        .to_return(successful_response({arguments: {torrents: torrents}}))
  end

  def torrent_get_body(arguments = {})
    args = {fields: Transmission::Fields::TorrentGet.new.to_fields}.merge(arguments)
    {method: 'torrent-get', arguments: args}.to_json
  end

  def torrent_add_body(arguments = {})
    {method: 'torrent-add', arguments: arguments}.to_json
  end

  def torrent_remove_body(arguments = {})
    {method: 'torrent-remove', arguments: arguments}.to_json
  end

  def session_get_body(arguments = {})
    {method: 'session-get', arguments: arguments}.to_json
  end

  def session_set_body(arguments = {})
    {method: 'session-set', arguments: arguments}.to_json
  end

  def session_stats_body(arguments = {})
    {method: 'session-stats', arguments: arguments}.to_json
  end

  def successful_response(options = {})
    body = {result: 'success', arguments: (options[:arguments] || {})}
    {status: 200, body: body.to_json, headers: options[:headers] || {}}
  end

  def unsuccessful_response(options = {})
    body = {result: (options[:result] || ''), arguments: (options[:arguments] || {})}
    {status: 200, body: body.to_json, headers: options[:headers] || {}}
  end

  def unauthorized_response(options = {})
    {status: 401, body: (options[:body] || {}).to_json, headers: options[:headers] || {}}
  end

  def conflict_response(options = {})
    {status: 409, body: (options[:body] || {}).to_json, headers: options[:headers] || {}}
  end

end