#require_dependency "user"

module PengZuo
	module UserPatch
		def self.included(base)
			
			base.extend(ClassMethods)
			base.send(:include, InstanceMethods) 

			base.class_eval do 
				has_many :ez_mail_templates, :order => "created_at desc", :dependent => :delete_all
			end
		end        
		
		module ClassMethods
			
		end                
		
		module InstanceMethods 
		end             
		
	end
end            

