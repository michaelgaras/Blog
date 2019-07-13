# frozen_string_literal: true

class AddGravatarUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gravatar, :string
  end
end
