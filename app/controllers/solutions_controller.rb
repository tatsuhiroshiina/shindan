class SolutionsController < ApplicationController
  def import
    Solution.import(params[:file])
    redirect_to root_url
  end
end
