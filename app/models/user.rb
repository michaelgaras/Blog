# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  before_save { self.email = email.downcase }
end
