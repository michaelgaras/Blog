# frozen_string_literal: true

class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

  belongs_to :user
  validates :user_id, presence: true

  def self.search(search)
    if search
      Article.where.any_of('title LIKE ?', "%#{search}%")
    else
      Article.where(private: false)
    end
  end
end
