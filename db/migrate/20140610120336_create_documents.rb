class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string     :name, default: nil, null: false
      t.string     :path, default: nil, null: false
      t.string     :extension, default: nil, null: false

      t.integer    :category_id, default: nil, null: false

      ########
      t.timestamps
    end
    add_index :documents, :path, unique: true
  end
end
