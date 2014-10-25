class ChangeUserOathTokenToText < ActiveRecord::Migration
  def self.up
    change_column :users, :oauth_token, :text
  end

  def self.down
    change_column :users, :oauth_token, :string
  end
end
