class YouTubeSearch

  def self.search(params)
    client = YouTubeIt::Client.new

    response = client.videos_by(params)

    result = []

    unless response.max_result_count == 0

      video_struct = Struct.new("Video", :title, :published_at, :description, :author, :duration, :url, :view_count, :rating, :rating_descr, :categories, :thumbnail)

      video_struct.class_eval do
        def to_map
          map = Hash.new
          self.members.each { |m| map[m] = self[m] }
          map
        end

        def to_json(*a)
          to_map.to_json(*a)
        end
      end

      response.videos.each do |video|

        single_video = video_struct.new(
            video.instance_variable_defined?("@title") ? video.title : '',
            video.instance_variable_defined?("@published_at") ? video.published_at.to_s : '',
            video.instance_variable_defined?("@description") ? video.description : '',
            if video.instance_variable_defined?("@author")
              video.author.instance_variable_defined?("@name") ? video.author.name : ''
            else
              ''
            end,
            video.instance_variable_defined?("@duration") ? Time.at(video.duration).utc.strftime("%H:%M:%S").to_s : '',
            video.instance_variable_defined?("@player_url") ? video.player_url : '',
            video.instance_variable_defined?("@view_count") ? ActiveSupport::NumberHelper::number_to_delimited(video.view_count) : '',
            if video.instance_variable_defined?("@rating")
              video.rating.instance_variable_defined?("@average") ? video.rating.average.round(2) : ''
            else
              ''
            end,
            if video.instance_variable_defined?("@rating")
              rating = video.rating.instance_variable_defined?("@average") ? video.rating.average.round(2).to_s : ''

              if video.rating.instance_variable_defined?("@max")
                rating << ' of ' << video.rating.max.to_s
              else
                rating
              end
            else
              ''
            end,
            '',
            ''
        )

        if video.instance_variable_defined?("@categories") && video.categories.length > 0
          single_video.categories = video.categories.collect { |category| category.label }.join(',')
        end

        if video.instance_variable_defined?("@thumbnails") && video.thumbnails.length > 0
          video.thumbnails.each do |thumbnail|
            next if thumbnail.name != 'default'

            single_video.thumbnail = thumbnail.url

            break
          end
        end

        result.push single_video

      end

    end

    if result.length > 0
      result.sort! { |x, y| y.view_count <=> x.view_count }
    end

    result
  end

end