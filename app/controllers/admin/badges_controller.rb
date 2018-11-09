class Admin::BadgesController < Admin::BaseController
  before_action :set_badge, only: %i[edit destroy update show]

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def edit; end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badge_path(@badge);
    else
      render :edit
    end
  end

  def show; end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:title, :image, :description, :choice, :subject)
  end
end
