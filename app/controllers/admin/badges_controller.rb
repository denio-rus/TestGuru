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

  def make_the_rule(choice, subject)
    case choice
    when "1"
      "Category.find_by(title: #{subject}).tests.ids.sort == test_passage.category.test_passages.all_successful.where(user: current_user).pluck(:test_id).uniq.sort"
    when "2"
      "level = test_passage.test.level
      list = []
      current_user.test_passages.all_successful.each { |test_passage| list << test_passage.test.id if test_passage.test.level == level}
      Test.where(level: #{subject}.to_i).ids.sort == list.uniq.sort"
    when "3"
      "test_passage.test.id == Test.find_by(title: #{subject}).id && test_passage.id == current_user.test_passages.where(test: test_passage.test).ids.sort.first"
    when "4"
      "current_user.test_passages.all_successful.count == #{subject}.to_i"
    end
  end
end
