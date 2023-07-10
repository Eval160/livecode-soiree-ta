class AdoptionsController < ApplicationController
  def new
    @adoption = Adoption.new
    @cats = Cat.where.missing(:adoption)

    if params.dig(:filter, :breed) #  => if params[:filter] && params[:filter][:breed]
      @cats = @cats.where(breed: params[:filter][:breed])
    end
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
end
