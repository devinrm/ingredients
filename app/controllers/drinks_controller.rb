class DrinksController < ApiController
  before_action :set_drink, only: %i[show]

  # GET /drinks
  def index
    @drinks = Drink.select("id, title").all

    render json: @drinks.to_json
  end

  # GET /drinks/1
  def show
    @drink = Drink.find(params[:id])

    render json: @drink.to_json(
      include: {
        ingredients: { only: %i[id description] },
      },
    )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_drink
    @drink = Drink.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def drink_params
    params.require(:drink).permit(:title, :description, :steps, :source)
  end
end
