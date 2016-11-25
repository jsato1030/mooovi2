class ProductsController < RankingController
  def index
    @products = Product.order('open_date DESC').limit(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    if params[:keyword] == nil
      @products = []
    else
      @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
    end
  end
end
