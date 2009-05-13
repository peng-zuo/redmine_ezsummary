class EzContact < ActiveRecord::Base
	def self.import_contacts(contacts)
		begin
			transaction do 
				contacts.each do |contact|
				  create(:email => contact)
				end
			end
		rescue Exception => e
			# logger.info e.to_s
		end
		
	end
	validates_presence_of :email
	validates_uniqueness_of :email
end
