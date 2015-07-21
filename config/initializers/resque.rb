# Resque.redis = Redis.new(:url => 'http://localhost:6379')
# Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

uri = URI.parse(ENV["REDISTOGO_URL"])
# Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Resque.redis = Redis.new(url: uri)

# Dir["/carpoolbackend/app/jobs/*.rb"].each { |file| require file }