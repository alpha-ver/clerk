class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|

      t.text :question,         default: nil, null: false
      t.text :answer,           default: nil
      t.integer :user_id,       default: nil
      t.integer :document_id,   default: nil

      t.timestamps
    end
  end
end
