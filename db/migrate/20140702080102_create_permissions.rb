class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :about

      t.integer :category_id,  default: nil, null: false
      t.integer :user_id,      default: nil, null: false
      t.integer :status,       default: nil, null: false

      t.timestamps
    end

    add_index :permissions, [:category_id, :user_id], unique: true
    
  end
end
