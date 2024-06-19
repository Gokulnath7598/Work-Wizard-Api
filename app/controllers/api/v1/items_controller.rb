class Api::V1::ItemsController < Api::V1::BaseController
  # before_action :doorkeeper_authorize!, :validate_user! # equivalent of authenticate_user!
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = paginate Item.all
    render json: @items, each_serializer: ItemSerializer, meta: pagination_dict(@items)
  end
  
  def show
    render json: @item, serializer: ItemSerializer, status: :ok
  end

  def create
    @item = Item.new(item_params)
    if @item.save
        render json: @item, serializer: ItemSerializer, status: :created
    else
      throw_error(@item.error.full_messages, :unprocessible_entity)    
    end  
  end
  

  def update
    if @item.update(item_params)
      render json: @item, serializer: ItemSerializer,  status: :ok
    else
      throw_error(@item.error.full_messages, :unprocessible_entity)
    end    
  end

  def destroy
    unless @item.destroy
      throw_error(@item.error.full_messages, :unprocessible_entity)
    end  
  end
  
  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description)   
  end   
  
end
  