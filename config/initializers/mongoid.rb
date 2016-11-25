Mongoid::configure do |mongo_conf|
  mongo_conf.load!(File.join(SCRIPT_ROOT, "config/mongoid.yml"), :development)
end
