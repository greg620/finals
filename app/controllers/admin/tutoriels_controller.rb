class Admin::TutorielsController < Admin::AdminController

  def index
    @tutoriels = Tutoriel.all
  end

  def show
    redirect_to admin_tutoriel_path
  end

  def new
    @tutoriel = Tutoriel.new
  end

  def create
    @tutoriel = Tutoriel.new(tutoriel_params)

    if @tutoriel.valid?
      @tutoriel.save
      @tutoriel.user_id = current_user.id
      redirect_to admin_tutoriel_path
    else
      render :new
    end
  end

  def edit
    @tutoriel = Tutoriel.find(params[:id])
  end

  def update
    @tutoriel = Tutoriel.find(params[:id])
    if @tutoriel.update(tutoriel_params)
    else
      render :edit
    end
  end

  private

  def tutoriel_params
    params.require(:tutoriel).permit(:title, :user_id, :category_id, :content)
  end
end
