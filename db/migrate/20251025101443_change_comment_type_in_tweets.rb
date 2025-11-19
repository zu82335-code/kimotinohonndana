class ChangeCommentTypeInTweets < ActiveRecord::Migration[7.2]
  def change
 change_column :tweets, :comment, :text   
  end
end
