class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :notes
      t.date :due
      t.boolean :completed
      t.references :user
      t.references :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end