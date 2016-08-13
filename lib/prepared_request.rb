class PreparedRequest

  attr_accessor :headers, :uri, :method, :data

  def initialize(options={})
    @headers = options[:headers] || {}
    @uri = options[:uri] || ''
    @method = options[:method] || :get
    @data = options[:data] || nil
  end

  # Hash of HTTP headers

  # string with full request URI

  # symbol :get, :post, :put, :delete

end
