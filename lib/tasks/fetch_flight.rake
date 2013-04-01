desc "Fetch flights"
task :fetch_flights => :environment do
  require 'mechanize'
  POST_URI = 'https://calec.china-airlines.com/olb/us/asp/calendar.asp'
  puts "Start the fetching flights\n"

  # Read all subscription
  subscriptions = Subscription.all
  subscriptions.each do |s|
    puts "#{s.name}"
  end
end
