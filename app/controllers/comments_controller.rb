class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
    render :index
  end

  def new
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    render :new
  end

  def create
    @user = current_user
    @tweet = Tweet.find(params[:id])
    @comment = @tweet.comments.create(comment_params)
    @tweet.comments << @comment
    @user.comments << @comment
    redirect_to tweet_path(@tweet)
  end

  def show
    @comment = Comment.find(params[:comment_id])
    render :show
  end

  def update
    @tweet = Tweet.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    @comment.update(comment_params)
    redirect_to tweet_path(@tweet)
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    render :edit
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to tweets_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
