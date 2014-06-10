class CreateTemplateFields < ActiveRecord::Migration
  def change
    create_table :template_fields do |t|
      t.string  :val
      ###
      t.integer :template_id,  default: nil, null: false
      t.integer :field_id,     default: nil, null: false
      ###
      t.timestamps
    end

    add_index :template_fields, [:template_id, :field_id], unique: true
  end
end
