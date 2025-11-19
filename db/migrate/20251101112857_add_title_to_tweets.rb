class AddTitleToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :arasuji, :text
  end
end
