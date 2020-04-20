require 'test_helper'

class TextDocumentTest < ActiveSupport::TestCase

  def setup
    test_file = ActionDispatch::Http::UploadedFile.new({
      :filename => 'test.txt',
      :type => 'text/plain',
      :tempfile => File.new("#{Rails.root}/test/fixtures/files/test.txt")
    })
    @text_document = TextDocument.new(file_name: "",
                description: "Lorem ipsum.",
                file_content: "",
                textfile: test_file)
  end

  def setup_with_broken_file
    unreadable_test_file = ActionDispatch::Http::UploadedFile.new({
      :filename => 'test-2.txt',
      :type => 'text/plain',
      :tempfile => File.new("#{Rails.root}/test/fixtures/files/test-2.txt")
    })
    @unreadable_text_document = TextDocument.new(file_name: "",
                description: "Lorem ipsum.",
                file_content: "",
                textfile: unreadable_test_file)
  end

  def setup_with_big_file
    big_test_file = ActionDispatch::Http::UploadedFile.new({
      :filename => 'test-big.txt',
      :type => 'text/plain',
      :tempfile => File.new("#{Rails.root}/test/fixtures/files/test-big.txt")
    })
    @big_text_document = TextDocument.new(file_name: "",
                description: "Lorem ipsum.",
                file_content: "",
                textfile: big_test_file)
  end

  def setup_with_pdf
    pdf_file = ActionDispatch::Http::UploadedFile.new({
      :filename => 'test.pdf',
      :type => 'text/plain',
      :tempfile => File.new("#{Rails.root}/test/fixtures/files/test.pdf")
    })
    @pdf_document = TextDocument.new(file_name: "",
                description: "Lorem ipsum.",
                file_content: "",
                textfile: pdf_file)
  end

  test "should be valid" do
    assert @text_document.valid?
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

  # If the textfile has no filename, our TextDocument won't have a filename.
  test "should be invalid if textfile has no filename" do
    @text_document.textfile.original_filename = ""
    assert_not @text_document.valid?
  end

  test "should be invalid if textfile content cannot be read" do
    setup_with_broken_file
    assert_not @unreadable_text_document.valid?
  end

  test "should be invalid if textfile is > 3MB" do
    setup_with_big_file
    assert_not @big_text_document.valid?
  end

  test "should be invalid if file extension is not .txt" do
    setup_with_pdf
    assert_not @pdf_document.valid?
  end

  test "file_name should come from textfile name" do
    # Validate first so that the file_name gets set.
    @text_document.valid?
    assert_equal @text_document.file_name, @text_document.textfile.original_filename
  end

end
