class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true 
  has_many :question_tags
  has_many :tags, through: :question_tags

  validates :text, presence: true, length: { maximum: 255 }

end
