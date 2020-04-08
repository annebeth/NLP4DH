class TextDocument < ApplicationRecord
  validates :file_name, presence: true, uniqueness: true
  validates :description, length: { maximum: 255 }
  validates :file_content, presence: true
end
