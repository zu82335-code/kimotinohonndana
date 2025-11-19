class AddCommentToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :comment, :string
  end
end
