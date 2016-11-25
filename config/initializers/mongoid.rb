Mongoid::configure do |mongo_conf|
  conf = YAML.load_file(File.join(SCRIPT_ROOT, 'config/mongoid.yml'))
  host = conf['host']
  port = conf['port']
  db   = conf['db']
  mongo_conf.database = Mongo::MongoClient.new(host, port).db(db)
  mongo_conf.logger.level = 1
end
