# frozen_string_literal: true

class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

  belongs_to :user
  validates :user_id, presence: true
end
