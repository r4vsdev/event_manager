require 'csv'

def clean_zicode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone(phone)
  phone = phone.to_s.gsub(/\D/, '')
  if phone.size < 10 || phone.size > 11
    'Valid number not given'
  elsif phone.size == 11 && phone[0] != 1
    'Valid number not given'
  elsif phone.size == 11 && phone[0] == 1
    phone[1..-1]
  else
    phone
  end
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
  phone = clean_phone(col[:homephone])

  puts "#{name} #{zipcode} #{phone}"
end