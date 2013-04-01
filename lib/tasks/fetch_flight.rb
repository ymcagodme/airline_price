require 'mechanize'
require 'pry'
require 'colorize'

POST_URI = 'https://calec.china-airlines.com/olb/us/asp/calendar.asp'
INTERVAL = 60

count = 0

print "Trip type> "
trip = gets
trip.chomp!
puts "You choose #{trip} type"

browser = Mechanize.new
while true do
  start_time = Time.now


  page = browser.post(POST_URI, {
    "adult" => "1",
    "child" => "0",
    "cls"   => "Y",
    "depstn" => "LAX Los Angeles ",
    "arrstn" => "TPE Taipei(Taoyuan) ",
    "trip"   => trip.chomp,
    "depmon" => "201305May",
    "retmon" => "201306Jun",
    "depday" => "20",
    "retday" => "05"
  })

  table = page.search('table #outboundTable')

  if trip == 'RT'
    puts "Fetching Round Trip..."
    rows = table.search('tr')
    departure_date = rows.first.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/)[3]

    target_row = rows[4]
    return_date = target_row.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/).first

    cols = target_row.search('td')
    target_cell = cols[4]

    fare = target_cell.text.strip
  else
    puts "Fetching Onw Way Trip..."
    rows = table.search('tr')
    departure_date = rows.first.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/)[3]

    target_row = rows[1]
    return_date = 'N/A'

    cols = target_row.search('td')
    target_cell = cols[3]

    fare = target_cell.text.strip
  end

  elapsed_time = Time.now - start_time

  puts "====Result===="
  puts "#{count}\t#{Time.now}"
  puts "#{departure_date} - #{return_date}"
  if fare == "1,165"
    puts "Fare: #{"$".red}#{fare.red}"
  else
    puts "Fare: #{"$".green}#{fare.green}"
  end
  puts "=============="
  puts "Completed in #{elapsed_time} seconds"
  puts ""
  count += 1
  sleep(INTERVAL)
end

