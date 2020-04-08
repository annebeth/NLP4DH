class CreateTextDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :text_documents do |t|
      t.string :file_name
      t.text :description
      t.text :file_content

      t.timestamps
    end
  end
end
