class User < ApplicationRecord
  has_secure_password validations: false

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
