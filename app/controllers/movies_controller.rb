class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new
  end

  def index
    @list_of_movies = Movie.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show
    #@the_movie = Movie.where(id: params.fetch(:id)).first
    #@the_movie = Movie.find_by(id: params.fetch(:id)))
    @the_movie = Movie.find(params.fetch(:id))
  end

  def create
    #@the_movie = Movie.new
    #@the_movie.title = params.fetch(:movie).fetch(:title)
    #@the_movie.description = params.fetch(:movie).fetch(:description)
    movie_attributes = params.require(:movie).permit(:title, :description)
    @the_movie = Movie.new(movie_attributes)

    if @the_movie.valid?
      @the_movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render template: "movies/new"
    end
  end

  def edit
    @the_movie = Movie.find(params.fetch(:id))
  end

  def update
    movie_attributes = params.require(:movie).permit(:title, :description)
    @the_movie = Movie.find(params.fetch(:id))
    @the_movie.title = params.fetch(:movie).fetch(:title)
    @the_movie.description = params.fetch(:movie).fetch(:description)

    if @the_movie.valid?
      @the_movie.save
      redirect_to movie_url(@the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(@the_movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    @the_movie = Movie.find(params.fetch(:id))

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
