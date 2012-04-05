Tire.configure do
  url "http://index.bonsai.io"
end

BONSAI_INDEX_NAME = URL(ENV['BONSAI_INDEX_URL']).path[1..-1]