require 'digest'
class User < ActiveRecord::Base

	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	has_many :games, :foreign_key => "player1_id"
	has_many :games, :foreign_key => "player2_id"
								 
	
		
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name, :presence => true,
					 :length => { :maximum => 50 }
	validates :email, :presence => true,
					  :format => { :with => email_regex },	
					  :uniqueness => { :case_sensitive => false}
	validates :password, :presence => true,
						 :confirmation => true,
						 :length => { :within => 6..40 }
	
	before_save :encrypt_password
	
	def has_password?(submitted_password)
		#compare encrypted version of submitted password with encrypted_password
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil		
	end
	
	def game
		@game = Game.find_by_player1_id(id) || Game.find_by_player2_id(id) 
	end
	
	 def play_game
	
		@user = User.find_by_id(id)
		if Game.last.nil?
			Game.create(:player1_id => @user.id, :player1_name => @user.name)
		else
			if Game.last.player2_id.nil?
				Game.last.join(@user)
			else
				Game.create(:player1_id => @user.id, :player1_name => @user.name)
			end
		end
			
		
	end
		
	
	private
	
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
				
	
end

