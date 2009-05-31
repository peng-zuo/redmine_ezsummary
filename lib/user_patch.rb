#require_dependency "user"

module PengZuo
  module UserPatch
    def self.included(base)

      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        has_many :ez_mail_templates, :order => "created_at desc", :dependent => :delete_all
        has_many :ez_contacts, :order => "created_at desc", :dependent => :delete_all  do
          def import_contacts(*contacts)
            errors = {}
            begin
              transaction do
                contacts.each do |contact|
                  on_the_fly = find_or_create_by_email(contact)
                  if on_the_fly.errors.on(:email)
                    errors.merge! :recipients => on_the_fly.errors.on(:email)
                  end
                end
              end
            rescue Exception => e
              # logger.info e.to_s
            end
            return errors
          end

        end
      end
    end
  end

  module ClassMethods

  end

  module InstanceMethods
  end

end
            

