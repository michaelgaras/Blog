# frozen_string_literal: true

class AddUserIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :user_id, :integer
  end
end
