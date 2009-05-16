class EzContact < ActiveRecord::Base
	def self.import_contacts(*contacts)
		errors = {}
		begin
			transaction do 
				contacts.each do |contact|
					on_the_fly = find_or_create_by_email(contact)
					if on_the_fly.errors.on(:email)
				  	errors.merge! :email => on_the_fly.errors.on(:email)
					end
				end
			end
		rescue Exception => e
			# logger.info e.to_s
		end
		return errors
	end

	validates_uniqueness_of :email
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
