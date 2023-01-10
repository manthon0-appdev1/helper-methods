class DirectorsController < ApplicationController
  def new
    @the_director = Director.new
  end

  def index
    @list_of_directors = Director.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @list_of_directors
      end

      format.html
    end
  end

  def show
    #@the_movie = Movie.where(id: params.fetch(:id)).first
    #@the_movie = Movie.find_by(id: params.fetch(:id)))
    @the_director = Director.find(params.fetch(:id))
  end

  def create
    #@the_movie = Movie.new
    #@the_movie.title = params.fetch(:movie).fetch(:title)
    #@the_movie.description = params.fetch(:movie).fetch(:description)
    director_attributes = params.require(:director).permit(:name)
    @the_director = Director.new(director_attributes)

    if @the_director.valid?
      @the_director.save
      redirect_to directors_url, notice: "Director created successfully."
    else
      render template: "directors/new"
    end
  end

  def edit
    @the_director = Director.find(params.fetch(:id))
  end

  def update
    director_attributes = params.require(:director).permit(:name)
    @the_director = Director.find(params.fetch(:id))
    @the_director.name = params.fetch(:director).fetch(:name)

    if @the_director.valid?
      @the_director.save
      redirect_to director_url(@the_director), notice: "Director updated successfully."
    else
      redirect_to director_url(@the_director), alert: "Director failed to update successfully."
    end
  end

  def destroy
    @the_director = Director.find(params.fetch(:id))

    the_director.destroy

    redirect_to directors_url, notice: "Director deleted successfully."
  end
end
