class TextDocument < ApplicationRecord
  before_validation :set_file_name, :set_file_content
  default_scope -> { order(:created_at) }
  attr_accessor :textfile
  validates :file_name, presence: true, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :file_content, presence: true

  validate :file_size_validation
  validate :file_extension_validation

  def file_size_validation
    errors[:textfile] << "should be less than 3MB" if textfile.size > 3.megabytes
  end

  def file_extension_validation
    ext = File.extname(self.file_name)
    errors[:textfile] << "should be a plain text file" if ext.downcase != ".txt"
  end

  def set_file_name
    self.file_name = textfile.original_filename
  end

  def set_file_content
    content = textfile.read
    # If we can't read + force encode the file, we don't accept it.
    if content.force_encoding('utf-8').valid_encoding?
      self.file_content = content.force_encoding('utf-8')
    else
      self.file_content = ""
    end
  end
end
