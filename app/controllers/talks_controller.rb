class TalksController < ApplicationController
  respond_to :html, :json

  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @talks = Talk.includes(:artist).order(start: :asc)
    authorize @talks
  end

  def show
    @talk = Talk.find_by(slug: params[:id])
    $marcar_presenca = @talk.slug
    $talk = Talk.find_by(slug: $marcar_presenca)
    authorize @talk
    @title = @talk.title
    respond_with @talk
  end

  def marcar_presenca
    $talk = Talk.find_by(slug: $marcar_presenca)
    current_user.talks << $talk unless current_user.talks.find_by(slug: $marcar_presenca).present?
    binding.pry
  end

  def new
    @talk = Talk.new
    authorize @talk

    @artists = Artist.order(name: :asc)
    @title = 'Cadastro de palestra'
  end

  def create
    @talk = Talk.new(talk_params)
    authorize @talk

    @artists = Artist.order(name: :asc)
    @title = "Cadastro de palestra"

    if @talk.save
      redirect_to root_path, notice: 'Palestra cadastrada'
    else
      render :new
    end
  end

  protected

  def talk_params
    params.require(:talk).permit(:title, :description, :start, :finish, :artist_id, :image)
  end
end