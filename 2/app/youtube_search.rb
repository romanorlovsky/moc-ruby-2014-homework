require 'youtube_it'

class YouTubeSearch

  def self.search(params)
    client = YouTubeIt::Client.new

    response = client.videos_by(params)

    result = []

    unless response.max_result_count == 0

      video_struct = Struct.new("Video", :title, :published_at, :description, :author, :duration, :url, :view_count, :rating, :categories, :thumbnail)

      response.videos.each do |video|

        puts video.inspect

        single_video = video_struct.new(
            video.title,
            video.published_at,
            video.description,
            video.author.name,
            Time.at(video.duration).utc.strftime("%H:%M:%S"),
            video.player_url,
            video.view_count,
            video.rating.average.round(2),
            [],
            ''
        )

        if video.categories.length > 0
          video.categories.each do |category|
            single_video.categories.push category.label
          end
        end

        if video.thumbnails.length > 0
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