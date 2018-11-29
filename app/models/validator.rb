require 'date'
class Validator < ApplicationRecord

	EXPRESSION_DATE = "%d/%m/%Y"

	validates :placa, :date, :presence => true

	before_save :valid_date?

	def valid_date?
	  DateTime.parse(self.date) rescue false
	  true
	end
end