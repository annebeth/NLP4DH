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
    self.file_content = textfile.read.force_encoding('utf-8')
    # TODO: Figure out how to do these errors.
    # errors[:textfile] << "should be a plain text file" if ext.downcase != ".txt"
  end

end
