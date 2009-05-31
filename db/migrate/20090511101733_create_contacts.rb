class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :ez_contacts do |t|      
			t.string :email
            t.references :user
           # t.index :email
			t.timestamps
		end
  end


  def self.down
    drop_table :ez_contacts
  end
end
