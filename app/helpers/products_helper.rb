module ProductsHelper
  def render_products_name_option
    product_names = Product.all.map { |p| [p.title, p.title] }
  end
end
