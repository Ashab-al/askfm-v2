class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  USERNAME_REGEX = /\A@[a-zA-Z0-9_]+\z/i

  has_many :questions, dependent: :destroy

  validates :username, format: {with: USERNAME_REGEX,
                                message: "должен быть в формате @username"}, 
                       presence: true,
                       uniqueness: true
  validates :avatar_url, format: {with: /\Ahttps?:\/\/.*\z/,
                                  message: "должен быть URL-адресом"},
                                  allow_blank: true,
                                  if: -> {avatar_url_changed?}

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "Рубист_#{rand(777)}" if self.name.blank?     
  end
end
