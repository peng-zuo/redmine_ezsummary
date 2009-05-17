class CreateEzMailTemplates < ActiveRecord::Migration
  def self.up
    create_table :ez_mail_templates do |t|
			t.text :content
			t.integer :user_id
			t.timestamps
    end
  end

  def self.down
    drop_table :ez_mail_templates
  end
end
