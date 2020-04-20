require 'test_helper'

class TextDocumentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @text_document = text_documents(:one)
    @most_recent_text_document = text_documents(:most_recent)
  end

  test "should get index" do
    get text_documents_path
    assert_response :success
  end

  test "order in index should be most recent last" do
    assert_equal @most_recent_text_document, TextDocument.last
  end

  test "should get new" do
    get new_text_document_path
    assert_response :success
  end

  test "should get show" do
    get text_document_path(@text_document)
    assert_response :success
  end

  test "should destroy and redirect" do
    assert_difference 'TextDocument.count', -1 do
      delete text_document_path(@text_document)
    end
    assert_redirected_to text_documents_path
  end

end
