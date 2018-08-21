class TestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def show
    redirect_to root_path
  end

  def new
  end

  def create
    test = Test.create(params.require(:test).permit(:title,:level))
    render plain: test.inspect
  end
end
