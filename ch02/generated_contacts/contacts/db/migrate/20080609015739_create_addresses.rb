class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.references :contact
      t.references :company

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end