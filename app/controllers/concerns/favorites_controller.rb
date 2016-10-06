class FavoritesController < ApplicationController

  def patch
    @favorite = Favorite.new
  end

  def new
    binding.pry
    @favorite = Favorite.new
  end

  def create
    binding.pry
    @favorites = Favorite.new(favorite_params)
    binding.pry
  end

  private
    def favorite_params
      params.require(:favorite).permit(params[:])
    end

end
