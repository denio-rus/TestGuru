class AchievementsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @achievements = current_user.achievements
  end

  def show
  end
end
