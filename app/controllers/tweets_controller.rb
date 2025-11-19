class TweetsController < ApplicationController
 before_action :authenticate_user!
  def index
    @tweets = Tweet.all
    @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
     tweet.destroy
     redirect_to action: :index
  end

  def random
    @tweets = Tweet.order("RANDOM()").first
    redirect_to @tweets
  end

  def search
  # タグ検索がある場合
  if params[:tag_id].present?
    @tweets = Tag.find(params[:tag_id]).tweets

  # キーワード検索がある場合
  elsif params[:search].present?
    @tweets = Tweet.where(
      "body LIKE :q OR comment LIKE :q OR arasuji LIKE :q",
      q: "%#{params[:search]}%"
    )

  # 何もない場合 → 全件
  else
    @tweets = Tweet.all
  end

  # ランキングは常に表示
  @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  end


  private
  def tweet_params
    params.require(:tweet).permit(:body, :image, :comment, :arasuji, tag_ids: [])
  end 
end
