require 'mechanize'
require 'pry'
require 'colorize'

POST_URI = 'https://calec.china-airlines.com/olb/us/asp/calendar.asp'
INTERVAL = 60

count = 0

while true do
  start_time = Time.now

  browser = Mechanize.new

  page = browser.post(POST_URI, {
    "adult" => "1",
    "child" => "0",
    "cls"   => "Y",
    "depstn" => "LAX Los Angeles ",
    "arrstn" => "TPE Taipei(Taoyuan) ",
    "trip"   => "RT",
    "depmon" => "05MAY",
    "retmon" => "06JUN",
    "depday" => "20",
    "retday" => "05",
    "depRef" => "2013-05-20",
    "retRef" => "2013-06-05",
    "fix"    => "fix"
  })

  table = page.search('table #outboundTable')
  rows = table.search('tr')
  departure_date = rows.first.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/)[3]

  target_row = rows[4]
  return_date = target_row.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/).first

  cols = target_row.search('td')
  target_cell = cols[4]

  fare = target_cell.text.strip

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
