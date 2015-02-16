@config = YAML.load_file(File.expand_path("./db/config.yml"))[settings.environment.to_s]

ActiveRecord::Base.establish_connection @config

class Author < ActiveRecord::Base
  has_many :videos
  has_many :articles
end

class Video < ActiveRecord::Base
  belongs_to :author, counter_cache: true
  has_many :comments, as: :c_object
end

class Article < ActiveRecord::Base
  belongs_to :author, counter_cache: true
  has_many :comments, as: :c_object
end

class Comment < ActiveRecord::Base
  belongs_to :c_object, polymorphic: true, counter_cache: true
end
