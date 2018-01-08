class AddressesController < ApplicationController

  layout false
  before_action :auth_user
  before_action :find_address, only: [:edit, :update, :destroy, :set_default_address]
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id desc")
  end

  def new
    @product = Product.new
    @root_categories = Category.roots
  end

  def create
    @product = Product.new(params.require(:product).permit!)
    @root_categories = Category.roots

    if @product.save
      flash[:notice] = "创建成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def edit
    @root_categories = Category.roots
    render action: :new
  end

  def update
    @product.attributes = params.require(:product).permit!
    @root_categories = Category.roots
    if @product.save
      flash[:notice] = "修改成功"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "删除失败"
      redirect_to :back
    end
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end
  def address_params
    params.require(:address).permit(:contact_name, :cellphone, :address,
      :zipcode, :set_as_default)
  end

  def find_address
    @address = current_user.addresses.find(params[:id])
  end

  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
