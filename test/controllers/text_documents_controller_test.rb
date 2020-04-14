require 'test_helper'

class TextDocumentsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get text_documents_path
    assert_response :success
  end

  test "order in index should be most recent last" do
    assert_equal text_documents(:most_recent), TextDocument.last
  end

  test "should get new" do
    get new_text_document_path
    assert_response :success
  end

end
