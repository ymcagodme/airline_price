desc "Fetch flights"
task :fetch_flights => :environment do
  require 'mechanize'
  POST_URI = 'https://calec.china-airlines.com/olb/us/asp/calendar.asp'
  start_time = Time.now
  browser = Mechanize.new

  puts "Start the fetching flights\n"

  count = 0

  # Read all subscription
  subscriptions = Subscription.all
  subscriptions.each do |s|
    page = browser.post(POST_URI, {
      "adult" => "1",
      "child" => "0",
      "cls"   => "Y",
      "depstn" => "LAX Los Angeles ",
      "arrstn" => "TPE Taipei(Taoyuan) ",
      "trip"   => "RT",
      "depmon" => s.depart_date.strftime("%Y%m%^b"),
      "retmon" => s.return_date.strftime("%Y%m%^b"),
      "depday" => s.depart_date.strftime("%d"),
      "retday" => s.return_date.strftime("%d")
    })

    table = page.search('table #outboundTable')
    rows = table.search('tr')
    departure_date = rows.first.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/)[3]

    target_row = rows[4]
    return_date = target_row.text.scan(/\d{2}\/\d{2}[a-zA-Z]{3}/).first

    cols = target_row.search('td')
    target_cell = cols[4]

    fare = target_cell.text.strip
    fare = fare.sub(/,/, "").to_f

    if s.flight_prices.last.price != fare
      s.flight_prices.create!(price: fare)
      count += 1
    end
  end

  elapsed_time = Time.now - start_time
  puts "Totally updated #{count} subscriptions in #{elapsed_time} seconds"
end
