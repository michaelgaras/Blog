# frozen_string_literal: true

class AddFriendsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friends, :text, array: true, default: []
  end
end
