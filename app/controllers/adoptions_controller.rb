class AdoptionsController < ApplicationController
  before_action :set_cats, only: [:new, :create]

  def new
    @adoption = Adoption.new
  end

  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user = current_user
    if @adoption.save
      redirect_to root_path
    else
      render :new, status: 422
    end
  end

  private

  def adoption_params
    params.require(:adoption).permit(:cat_id)
  end

  def set_cats
    @cats = Cat.includes(photo_attachment: :blob)
               .where.missing(:adoption)

    if params.dig(:filter, :breeds) #  => if params[:filter] && params[:filter][:breeds]
      @cats = @cats.where(breed: params[:filter][:breeds])
    end
  end
end
