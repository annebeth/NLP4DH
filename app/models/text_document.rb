class TextDocument < ApplicationRecord
  default_scope -> { order(:created_at) }
  attr_accessor :textfile
  validates :file_name, presence: true, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :file_content, presence: true

end
