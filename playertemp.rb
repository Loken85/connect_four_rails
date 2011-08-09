class Player
	attr_accessor :name, :id

	def initialize(attributes = {})
		@name = attributes[:name]
		
		@id = attributes[:id]
	end
	
end	