require 'json'

response = '[{"name":"Person1","email":"person1@gmail.com","sex":"male","dob":"12\/12\/1990","skype":"skype.person1","phone":"38091211212","website":"person1.blogspot.com","avatar":"person1.png","country":"Ukraine","city":"Cherkassy","university":"KNP"},{"name":"Person2","email":"person2@gmail.com","sex":"female","phone":"38091211114"},{"name":"Person3","dob":"12\/12\/1990","phone":"38091211413","website":"person1.blogspot.com"},{"name":"Person4","skype":"skype.person1","phone":"38091211212","website":"person1.blogspot.com"},{"name":"Person5","email":"person5@gmail.com","sex":"male","country":"Ukraine","city":"Cherkassy","university":"KNP"},{"email":"person6@gmail.com","sex":"male","country":"Ukraine","city":"Cherkassy","university":"KNP"}]'

response = JSON.parse(response)

person = Struct.new('Person', :name)

person.class_eval do
  def call_person_method method
    unless (/_person$/=~method).nil?
      if self.respond_to? method
        self.send(method)
      end
    end
  end

  def call_all_person_methods
    self.singleton_methods.each do |method|
      call_person_method method
    end
  end
end

persons = []

response.each do |item|

  next if item['name'].nil? || item['name'].strip.length == 0

  p = person.new(item['name'].strip)

  item.each do |key, value|

    next if key == 'name'

    p.define_singleton_method key do
      instance_variable_get "@#{key}"
    end

    p.instance_variable_set "@#{key}", value

    case key
      when 'email' then
        p.define_singleton_method 'send_email_person' do
          puts 'Send email from ruby@gmail.com to ' + p.send(key)
        end
      when 'skype' then
        p.define_singleton_method 'skype_call_person' do
          puts 'Call from skype.ruby to ' + p.send(key)
        end
      when 'phone' then
        p.define_singleton_method 'phone_call_person' do
          puts 'Call from phone.ruby to ' + p.send(key)
        end
      when 'website' then
        p.define_singleton_method 'visit_website_person' do
          puts 'Visit website ' + p.send(key)
        end
      when 'avatar' then
        p.define_singleton_method 'show_avatar_person' do
          puts 'Show avatar ' + p.send(key)
        end
      else
    end
  end

  persons.push(p)

end

persons.each do |p|

  puts "===============================================#{p.name}======================================================="

  p.instance_variables.each do |var|
    puts var.to_s.gsub(/^@/, '').capitalize + ': ' + (p.instance_variable_get var).to_s
  end

  puts ''
  puts 'Methods:'

  p.call_all_person_methods

  puts '==============================================================================================================='
  puts ''

end