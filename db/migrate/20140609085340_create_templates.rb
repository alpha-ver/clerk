class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string     :name,    default: nil, null: false
      t.text       :about
      t.integer    :user_id, default: nil, null: false

      t.timestamps
    end
    
    add_index :templates, :user_id
  end
end
