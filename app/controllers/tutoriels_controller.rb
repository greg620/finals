class TutorielsController < ApplicationController

  def index
    @tutoriels = Tutoriel.all
  end

  def show
    @category = Category.where(slug: params[:category_name]).first
  end

  def show_tutoriel
    cat = Category.where(slug: params[:category]).first
    @tutoriel = Tutoriel.where(category_id: cat.id).first
  end
end
