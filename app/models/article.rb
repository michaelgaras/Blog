# frozen_string_literal: true

class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }

  belongs_to :user
  validates :user_id, presence: true

  def self.search(search)
    @public_articles = Article.where(private: false)
    if search
      @word_upcase = sanitize_downcase(search)
      @word_downcase = sanitize_upcase(search)
      search_by_title.or(search_by_description)
    # .or(search_by_username)
    else
      @public_articles
    end
  end

  def self.search_by_title
    @public_articles.where('title LIKE ?', "%#{@word_downcase}%")
                    .or(@public_articles.where('title LIKE ?', "%#{@word_upcase}%"))
  end

  def self.search_by_username
    User.all.where('username LIKE ?', "%#{@word_downcase}%")
        .or(@public_articles.where('username LIKE ?', "%#{@word_upcase}%"))
  end

  def self.search_by_description
    @public_articles.where('description LIKE ?', "%#{@word_downcase}%")
                    .or(@public_articles.where('description LIKE ?', "%#{@word_upcase}%"))
  end

  def self.sanitize_upcase(word)
    word.split.map(&:capitalize).join(' ')
  end

  def self.sanitize_downcase(word)
    word.split.map(&:downcase).join(' ')
  end
end
