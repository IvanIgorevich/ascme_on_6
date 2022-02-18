require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions, dependent: :destroy

  before_save :encrypt_password
  before_validation :username_email_downcase

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: /\A\w+@\w+\.\w+/ }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: /\A\w+\z/ }
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :color, format: { with: /\A#\h{3}{1,2}\z/ }

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    email&.downcase!
    user = find_by(email: email)

    return unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def username_email_downcase
    username&.downcase!
    email&.downcase!
  end
end
