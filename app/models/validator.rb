class Validator < ApplicationRecord
	validates :placa, :presence => true
end
