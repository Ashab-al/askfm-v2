class User < ApplicationRecord
  
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new 

  EMAIL_REGEX = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  USERNAME_REGEX = /\A@[a-zA-Z0-9_]+\z/i


  has_many :questions, dependent: :destroy
  has_many :posts, dependent: :destroy


  validates :username, format: {with: USERNAME_REGEX,
                                message: "должен быть в формате @username"}, 
                       presence: true,
                       uniqueness: true
  validates :email, format: {with: EMAIL_REGEX},
                    presence: true,
                    uniqueness: true
  validates :password, presence: true, on: :create,
                      confirmation: true,
                      length: { minimum: 8,
                                message: "минимальная длина 8" },
                      format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).*\z/,
                                message: "должен включать хотя бы одну букву и одну цифру" }
  validates :avatar_url, format: {with: /\Ahttps?:\/\/.*\z/,
                                  message: "должен быть URL-адресом"},
                                  allow_blank: true,
                                  if: -> {avatar_url_changed?}

  before_save :encrypt_password

  attr_accessor :password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email) 

    if user.present? && user.password_hash == User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, user.password_salt,
          ITERATIONS,
          DIGEST.length, DIGEST
        )
      )
      user
    else
      nil
    end
  end

  private

  def encrypt_password 
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          self.password, self.password_salt,
          ITERATIONS,
          DIGEST.length, DIGEST
        )
      )
    end
  end
end
