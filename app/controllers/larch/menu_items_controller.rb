class Larch::MenuItemsController < ApplicationController

  before_action :find_menu_item, except: [:index,:create]

  # GET /admin/menu_items
  def index
    render_tree
  end

  # GET /admin/menu_items/1
  def show
    render json: @menu_item, serializer: Larch::MenuItemSerializer, root: 'menu_item'
  end

  # POST /admin/menu_items
  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      render json: @menu_item, serializer: Larch::MenuItemSerializer
    else
      render_error @menu_item
    end
  end

  # PATCH/PUT /admin/menu_items/1
  def update
    if @menu_item.update(menu_item_params)
      render_tree @menu_item
    else
      render_error @menu_item
    end
  end

  def move
    if params[:up].present?
      @menu_item.move_higher
    else
      @menu_item.move_lower
    end

    @menu_item.save
    render_tree @menu_item
  end

  # DELETE /admin/menu_items/1
  def destroy
    @menu_item.destroy
    head :no_content
  end

  private

  def render_item
    render json: Larch::MenuItemSerializer.new(@menu_item, root: 'menu_item')
  end

  # TODO: render only the necessary nodes
  def render_tree(node = nil)
    items = MenuItem.order("position ASC").all
    render json: ActiveModel::ArraySerializer.new(items, each_serializer: Larch::MenuItemSerializer, root: 'menu_items')
  end

  def find_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:title_en,:title_cs,:parent_id,:position,:content_id,:content_type)
  end

  def default_format_json
    if request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?
      request.format = "json"
    end
  end

  def render_error(model)
    full = model.errors.full_messages.join('. ')
    render json: { errors: model.errors, full_message: "#{full}." },
           status: 422
  end

end
