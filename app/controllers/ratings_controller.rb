class RatingsController < ApplicationController
  before_action :set_movie

  def create
    @rating=@movie.ratings.new(rating_params)
    respond_to do |format|
      if @rating.save
        ratings = Hash[(1..5).reverse_each.map { |n| [n, 0] }]
        @ratings = ratings.merge @movie.ratings.group(:star).count
        format.html { redirect_to movie_path(@movie), notice: @rating.save ? "Rating saved successfully" : 'Please select any one of the Rating'}
        format.js
      end
    end
  end

  private

  def set_movie
    @movie=Movie.find(params[:movie_id])
  end

  def rating_params
    params.require(:rating).permit(:star, :movie_id)
  end
end
