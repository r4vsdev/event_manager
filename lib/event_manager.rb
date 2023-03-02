# frozen_string_literal: true

require 'csv'
require 'date'
# require 'time'

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
    phone[1..]
  else
    phone
  end
end

def get_hour(reg_date)
  DateTime.strptime(reg_date, '%m/%d/%y %H:%M').hour
end

# def clean_date(reg_date)
#   Date.strptime(reg_date.split(' ').first, '%m/%d/%y').wday
# end

puts 'EventManager initialized.'

contents = CSV.open(
  '../event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

hours = []
contents.each do |col|
  # name = col[:first_name]
  # zipcode = clean_zicode(col[:zipcode])
  # phone = clean_phone(col[:homephone])
  hours << get_hour(col[:regdate])

  # puts "#{name} #{zipcode} #{phone}"
end
peak = []
hours.tally.each { |k, v| peak << k if v == hours.tally.values.max }

puts "peak hours = #{peak}"
