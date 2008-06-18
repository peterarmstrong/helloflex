class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :home_phone
      t.string :mobile_phone
      t.string :work_phone
      t.string :skype
      t.string :facebook
      t.string :twitter
      t.string :blog
      t.text :notes
      t.references :user
      t.references :company

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end