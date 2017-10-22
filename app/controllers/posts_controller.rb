class PostsController < ApplicationController

  before_action :loggedIn
  skip_before_action :verify_authenticity_token

  def draft_index
    loggedIn
    @draft = Post.where(user_id: current_user.id)
  end

  def draft
    notAuthorize
    @draft = Post.new
  end

  def create_draft
    post_params = params.require(:post).permit(:title, :content)

    @draft = Post.new(post_params)

    if @draft.valid?
      @draft.save
      @draft.update_attributes(user_id: current_user.id)
      redirect_to draft_index_path, success: "L'article a bien été créer"
    else
      render :draft
    end
  end

  def edit_draft
    loggedIn
    @draft = Post.find(params[:id])
  end

  def update_draft
    @draft = Post.find(params[:id])
    post_params = params.require(:post).permit(:title, :content)

    if @draft.update(post_params)
      redirect_to draft_index_path, success: "L'article a bien été édité"
    else
      render :edit_draft
    end
  end

  def publish
    @article = Post.where(user_id: current_user.id).find(params[:id])

    if @article.user_id = current_user.id
      @article.update_attributes(published: 1)
      redirect_to draft_index_path, success: "Votre article a bien été publié il est maintenant en ligne sur le blog", error: "A noter que si l'article n'est pas conforme au site il sera supprimer"
    end
  end

  def unpublish
    @article = Post.where(user_id: current_user.id).find(params[:id])

    if @article
      @article.update_attributes(published: 0)
      redirect_to draft_index_path, success: "Votre article a bien été retirer du blog"
    else
      render "/errors/404"
    end
  end
end
