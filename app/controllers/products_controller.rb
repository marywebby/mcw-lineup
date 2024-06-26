class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action { authorize (@product || Product)}

  # GET /products or /products.json
  def index
    @breadcrumbs = [
      {content: "Products", href: products_path}
    ]
    @q = Product.page(params[:page]).ransack(params[:q])
    @products = @q.result
  end

  # GET /products/1 or /products/1.json
  def show
    @breadcrumbs = [
      {content: "Products", href: products_path},
      {content: @product.name, href: products_path(@product)},
    ]
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :type_of_product_id)
    end
end
