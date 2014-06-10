class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id, default: nil, null: false

      t.timestamps
    end
    
  end
end
