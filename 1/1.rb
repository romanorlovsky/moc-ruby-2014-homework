require 'json'

module SocialProfiles

  module ClassMethods

    def social_profiles(*profiles)

      profiles.each do |profile|

        define_method "#{profile}_account?" do

          if self.include? social_profiles and self.social_profiles.kind_of?(Array) and self.social_profiles.count
            self.social_profiles.any? { |p| /https?:\/\/(www\.)?#{profile.to_s.downcase}/=~p.downcase }
          else
            false
          end

        end

      end

    end

  end

  #avoid extend and include
  def self.included(base)
    base.extend(ClassMethods)
  end

end

response = '{"person":{"personal_data":{"name": "John Smith", "gender":"male", "age":56},"social_profiles":["https://facebook.com","http://twitter.com","http://www.linkedin.com"],"additional_info":{"email":"person@gmail.com", "hobby":["pubsurfing","drinking","hiking"], "pets":[{"name":"Mittens","species":"Felis silvestris catus"}]}}}'

response = JSON.parse(response)

if response.key?('person')

  response = response['person']

  if response.key?('personal_data') and response['personal_data'].key?('name')

    fields = response['personal_data'].keys.concat(response.keys.find_all { |item| item != 'personal_data' }).collect(&:to_sym)

    person_object = Struct.new("Person", *fields)

    person_object.class_eval do

      include SocialProfiles

      def get_person_property(property)

        if self.members.any? { |m| m == property.to_sym }
          self.send(property.to_sym)
        else
          nil
        end

      end

      social_profiles :facebook, :twitter, :vk, :linkedin

    end

    data = (response.select { |key, value| key != 'personal_data' }).values

    person = person_object.new(*response["personal_data"].values.concat(data))

    person.instance_eval do

      def adult?

        self.get_person_property('age').to_i >= 18

      end

      def have_hobbies?

        !self.get_additional_info('hobby').empty?

      end

      def have_pets?

        !self.get_additional_info('pets').empty?

      end

      def get_additional_info(property)

        info = self.get_person_property('additional_info')

        if info.nil?
          false
        elsif info.key?(property)
          info[property]
        else
          false
        end

      end

    end

    puts 'Person'
    puts 'Name: ' << person.get_person_property('name').to_s
    puts 'Gender: ' << person.get_person_property('gender').to_s
    puts 'Age: ' << person.get_person_property('age').to_s
    puts 'Is adult: ' << person.adult?.to_s
    puts 'Email: ' << person.get_additional_info('email').to_s

    puts 'Have hobbies: ' << person.have_hobbies?.to_s

    if person.have_hobbies?
      puts 'Hobbies: ' << person.get_additional_info('hobby').join(', ')
    end

    puts 'Have pets: ' << person.have_pets?.to_s

    if person.have_pets?
      puts 'Pets: '

      person.get_additional_info('pets').each_with_index do |item, index|
        if index > 0
          puts '  ---------------------------------'
        end

        item.each { |key, value| puts '  ' << key.to_s.capitalize << ': ' << value.to_s }
      end
    end

    puts 'Have Twitter account: ' << person.twitter_account?.to_s
    puts 'Have Facebook account: ' << person.facebook_account?.to_s
    puts 'Have VK account: ' << person.vk_account?.to_s
    puts 'Have Linkedin account: ' << person.linkedin_account?.to_s

  end
end