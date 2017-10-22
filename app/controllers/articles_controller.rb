class ArticlesController < ApplicationController

  def index
    @posts = Post.where(published: 1)
  end

  def show
    @post = Post.friendly.where(published: 1).find(params[:id])
    if current_user
      @like = Like.where(post_id: @post.id, user_id: current_user.id, commentable: :post).first
    end
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id, parent_id: 0)
  end

  def like
    post = Post.find(params[:post_id])
    like = Like.where(user_id: current_user.id, post_id: post.id, commentable: :post).first
    if like
      redirect_to article_path(post), error: "Vous aimez dèja cette article"
    else
      Like.create(post_id: params[:post_id], user_id: params[:user_id])
      redirect_to article_path(post), success: "Merci pour votre j'aime"
    end
  end

  def unlike
    like = Like.where(user_id: current_user.id, commentable: :post).first
    post = Post.find(params[:post_id])

    if post.nil?
      redirect_to root_path, error: "Cet article n'existe pas"
    end

    if like
      Like.destroy(params[:id])
      redirect_to article_path(post), success: "Vous n'aimez plus cet article"
    end
  end

  def create_comment
    if current_user
      comment_params = params.require(:comment).permit(:content, :parent_id)
      @comment = Comment.new(comment_params)
      @post = Post.friendly.find(params[:slug])
      @comments = Comment.where(post_id: @post.id, parent_id: 0)
      @comment.post_id = @post.id
      @comment.user_id = current_user.id
      @comment.username = current_user.username
      @comment.email = current_user.email
    else
      comment_params = params.require(:comment).permit(:username, :email, :content, :parent_id)
      @comment = Comment.new(comment_params)
      @post = Post.friendly.find(params[:slug])
      @comments = Comment.where(post_id: @post.id, parent_id: 0)
      @comment.post_id = @post.id
      @comment.user_id = false
    end

    if @comment.valid?
      @comment.save
      redirect_to article_path(@post), success: "Le commentaire a bien été posté"
    else
      render :show
    end
  end
end
