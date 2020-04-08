require 'test_helper'

class TextDocumentTest < ActiveSupport::TestCase

  def setup
    # TODO: Replace file name and content by parallel to helper method. In fixtures?
    @text_document = TextDocument.new(file_name: "example.txt",
                description: "Lorem ipsum text",
                file_content: "Lorem ipsum dolor sit amet, consectetur adipiscing
                elit, sed do eiusmod tempor incididunt ut labore et
                dolore magna aliqua.")
  end

  test "should be valid" do
    assert @text_document.valid?
  end

  test "should be invalid without file_name" do
    @text_document.file_name = ""
    assert_not @text_document.valid?
  end

  # TODO: Test this at the DB level as well?
  test "file_name should be unique" do
    other_text_document = @text_document.dup
    @text_document.save
    assert_not other_text_document.valid?
  end

  test "description should be at most 255 characters" do
    @text_document.description = "a" * 256
    assert_not @text_document.valid?
  end

  test "should be invalid without file_content" do
    @text_document.file_content = ""
    assert_not @text_document.valid?
  end

end
