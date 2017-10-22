class DraftsController < ApplicationController
  def destroy
    @draft = Post.where(user_id: current_user.id).find(params[:id])
    if !@draft
      redirect_to draft_index_path, error: "Cet article ne vous appartient pas"
    else
      Post.destroy(params[:id])
      redirect_to draft_index_path, success: "L'article a bien été supprimé"
    end
  end
end
