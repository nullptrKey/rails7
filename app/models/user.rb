# frozen_string_literal: true
class User < ApplicationRecord
  has_many :articles,  dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: {maximum: 105},
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  has_secure_password

  def admin?
    admin == true
  end
end
