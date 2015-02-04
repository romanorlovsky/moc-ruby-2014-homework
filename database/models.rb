@config = YAML.load_file(File.expand_path("./db/config.yml"))[settings.environment.to_s]

ActiveRecord::Base.establish_connection @config

class Author<ActiveRecord::Base
  has_many :videos
end

class Video<ActiveRecord::Base
  belongs_to :author
end
