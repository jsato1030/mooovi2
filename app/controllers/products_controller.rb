class ProductsController < RankingController
  def index
    @products = Product.order('open_date DESC').limit(20)
  end

  def show
    @product = Product.find(params[:id])
  end
end
