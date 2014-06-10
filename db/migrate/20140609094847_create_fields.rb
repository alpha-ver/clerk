class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|

      t.string :name, default: nil, null: false
      t.string :code, default: nil, null: false
      t.text   :about 

      t.timestamps
    end
    add_index :fields, :code, unique: true
  end
end
