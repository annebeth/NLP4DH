class AddAnnotationToTextDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :text_documents, :annotation, :jsonb, null: false, default: '{}'
  end
end
