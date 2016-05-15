class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
    @following = current_user.following
  end

  def new
    @tweet = Tweet.new
    render :new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    @user = current_user
    @user.tweets << @tweet
    redirect_to user_path(@user)
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @following = current_user.following
    redirect_to user_path(@user)
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    redirect_to tweets_path
  end

  def edit
    @tweet = Tweet.find(params[:id])
    render :edit
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :latitude,:longitude)
  end

end
