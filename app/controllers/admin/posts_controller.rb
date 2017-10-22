
class Admin::PostsController < Admin::AdminController

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    post_params = params.require(:post).permit(:title, :content)

    if @post.update(post_params)
      redirect_to admin_article_index_path
    else
      render :edit
    end
  end
end