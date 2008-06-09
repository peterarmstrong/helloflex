class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :content
      t.references :user
      t.references :contact
      t.references :channel

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end