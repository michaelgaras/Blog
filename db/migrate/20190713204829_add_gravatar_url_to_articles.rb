# frozen_string_literal: true

class AddGravatarUrlToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :gravatar, :string
  end
end
