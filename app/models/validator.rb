require 'date'
require 'time'
class Validator < ApplicationRecord

 VALID_DAYS = {
 	monday: [1,2],
 	tuesday: [3,4],
 	wednesday: [5,6],
 	thursday: [7,8],
 	friday: [9,0]
 }

 INIT_MORNING = Time.parse("07:00")
 END_MORNING = Time.parse("09:30")
 INIT_NIGHT = Time.parse("16:00")
 END_NIGHT = Time.parse("19:30")
 
 PERIOD_TIME = [["07:00","09:30"], ["16:00","19:30"]]

 validates :placa, :date, :time, :presence => true

 def is_an_invalid_day?(last_digit)
 	last_digit = last_digit.to_i
 	current_date = DateTime.parse(self.date)
 	return false if current_date.saturday? || current_date.sunday?
 	if current_date.monday? && VALID_DAYS[:monday].include?(last_digit)
 		true
 	elsif current_date.tuesday? && VALID_DAYS[:tuesday].include?(last_digit)
 		true
 	elsif current_date.wednesday? && VALID_DAYS[:wednesday].include?(last_digit)
 		true
 	elsif current_date.thursday? && VALID_DAYS[:thursday].include?(last_digit)
 		true
 	elsif current_date.friday? && VALID_DAYS[:friday].include?(last_digit)
 		true
 	else
 		false
 	end
 end

 def is_an_invalid_hour?
 	hour = Time.parse(self.time)
 	if hour >= INIT_MORNING && hour <= END_MORNING ||
 	   hour >= INIT_NIGHT && hour <= END_NIGHT
 	   true
 	else
 	   false
 	end
 end

 def get_last_digit
 	length = self.placa.length
 	self.placa.slice(length-1)
 end
 
 def is_a_valid_placa?
   return false if self.placa.length != 8
   self.placa.match(/[A-Z]{3}|[a-z]{3}\-\d{4}/) ? true : false
 end
end