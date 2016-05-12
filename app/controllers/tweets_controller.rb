class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
    render :index
  end

  def new
    @tweet = Tweet.new
    render :new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    redirect_to tweets_path
  end

  def show
    @tweet = Tweet.find(params[:id])
    render :show
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
    params.require(:tweet).permit(:title, :body)
  end

end
