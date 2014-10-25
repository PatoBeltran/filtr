require 'ankusa'
require 'ankusa/mongo_db_storage'

if Rails.env == "development" || Rails.env == "test"
  STORAGE = Ankusa::MongoDbStorage.new host: ENV["MONGO_HOST"], port: ENV["MONGO_PORT"], db: ENV["MONGO_DB_NAME"]
else
  db = URI.parse(ENV["MONGOHQ_URL"])
  db_name = db.path.gsub(/^\//, '')

  STORAGE = Ankusa::MongoDbStorage.new host: db.host, port: db.port, db: db_name,  username: ENV["MONGO_USERNAME"], password: ENV["MONGO_PASSWORD"]
end
