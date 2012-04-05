BONSAI_INDEX_NAME = URI.parse(ENV['BONSAI_INDEX_URL']).path[1..-1]
Tire.configure do
  url "http://index.bonsai.io/#{BONSAI_INDEX_NAME}"
end
