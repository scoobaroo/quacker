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
    redirect_to user_path(@user)
  end

  def show
    @comment = Comment.find(params[:comment_id])
    render :show
  end

  def update
    @tweet = Tweet.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    if current_user == @comment.user
      @comment.update(comment_params)
    else
      flash[:notice]="Not your comment!"
    end
    redirect_to tweet_path(@tweet)
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    if current_user == @comment.user
      render :edit
    else
      flash[:notice]="Not your comment!"
      redirect_to tweet_path(@tweet)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @comment = Comment.find(params[:comment_id])
    if current_user == @comment.user
      @comment.destroy
    else
      flash[:notice]="Not your tweet!"
    end
    redirect_to tweet_path(@tweet)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
