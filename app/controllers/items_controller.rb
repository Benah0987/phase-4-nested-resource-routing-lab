class ItemsController < ApplicationController

  def index
    items = Item.all
    render json: items, include: :user
  end
  # creating a show action
  def show
    item = Item.find_by(id: params[:id], user_id: params[:user_id])
    render json: item
  end
  # creating a create action
  def create
    user = User.find_by(id: params[:user_id])
    item = user.items.build(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
