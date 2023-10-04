class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validate :user_id_exists


  private
  def user_id_exists
    unless User.exists?(id: user_id)
      errors.add(:user_id, "must exist in Users")
    end
  end
end
