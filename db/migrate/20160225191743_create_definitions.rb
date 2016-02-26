class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
