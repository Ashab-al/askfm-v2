class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true 
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :text, presence: true, length: { maximum: 255 }

  after_save :create_tags_from_question_text

  def create_tags_from_question_text
    tags = text.scan(/#\w+/)

    tags.each do |tag_text|
      tag = Tag.find_or_create_by(title: tag_text[1..-1])
      question_tags.find_or_create_by(tag: tag)
    end
  end
end
