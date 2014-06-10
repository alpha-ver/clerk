class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string     :name,       default: nil, null: false
      t.integer    :parent_id,  default: nil, null: false

      t.timestamps
    end
    add_index :categories, :name
  end
end
