class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :word
      t.string :pronunciation
      t.string :function
      t.string :origin

      t.timestamps null: false
    end
  end
end
