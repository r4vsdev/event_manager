require 'csv'

def clean_zicode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'EventManager initialized.'

contents = CSV.open(
  '../event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |col|
  name = col[:first_name]
  zipcode = clean_zicode(col[:zipcode])



  puts "#{name} #{zipcode}"
end
