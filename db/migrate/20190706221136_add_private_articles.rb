# frozen_string_literal: true

class AddPrivateArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :private, :boolean
  end
end
