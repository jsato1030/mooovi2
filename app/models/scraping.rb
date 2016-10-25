class Scraping
  def self.movie_urls
    agent = Mechanize.new
    links = []

    # パスの部分を変数で定義(はじめは、空にしておきます)
    next_url = ""

    while true do

      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search(".entry-title a")
      
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      # 「次へ」を表すタグを取得
      next_link = current_page.at('.pagination .next a')

      # next_linkがなかったらwhile文を抜ける
      break unless next_link
      
      # そのタグからhref属性の値を取得
      # next_url = next_link.get_attribute('href')
      next_url = next_link.get_attribute('href')
    end

    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end

  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text if page.at('.entry-title')
    #画像
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    #監督、あらすじ、公開日
    director = page.at('.director span').inner_text if page.at('.director span')
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    open_date = page.at('.date span').inner_text if page.at('.date span')
    #DB
    product = Product.where(title: title).first_or_initialize
    product.director = director
    product.detail = detail
    product.open_date = open_date
    product.save
  end

end