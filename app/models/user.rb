# frozen_string_literal: true

require_relative '../../lib/sanitizing'

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  before_save { self.email = email.downcase }

  has_many :articles
  has_secure_password

  def self.search(search)
    @users = User.all
    if search
      @word_upcase = sanitize_downcase(search)
      @word_downcase = sanitize_upcase(search)
      search_by_email.or(search_by_username)
    else
      @users
    end
  end

  def self.search_by_email
    @users.where('email LIKE ?', "%#{@word_downcase}%")
          .or(@users.where('email LIKE ?', "%#{@word_upcase}%"))
  end

  def self.search_by_username
    @users.where('username LIKE ?', "%#{@word_downcase}%")
          .or(@users.where('username LIKE ?', "%#{@word_upcase}%"))
  end

  def self.sanitize_upcase(word)
    word.split.map(&:capitalize).join(' ')
  end

  def self.sanitize_downcase(word)
    word.split.map(&:downcase).join(' ')
  end
end
