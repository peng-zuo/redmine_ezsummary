class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :ez_contacts do |t|      
			t.string :email
			t.timestamps
		end
  end


  def self.down
    drop_table :contacts
  end
end
