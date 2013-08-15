class AddFeedColumn < ActiveRecord::Migration
  def up
    add_column :channels, :feed, :string
  end
end
