class Scraping

  ## self.categories→self.brands→self.set_brands_for_categoryの順で実行する。

  def self.categories ## カテゴリーのスクレイピング
    agent = Mechanize.new
    current_page = agent.get("http://localhost:3000/items/scraping_category")

    parent_category_blocks = current_page.search('.category-list-individual-box')
    category_id = 1
    parent_category_blocks.each_with_index do |parent_category_block,i| ## 親カテゴリの配列を回す。
      parent_category = parent_category_block.at('h3').inner_text
      @parent_category = Category.where(id: category_id, name: parent_category).first_or_create ## 親カテゴリをcreate
      category_id += 1
      child_category_blocks = parent_category_block.search('.category-list-individual-box-sub-sub-category-box')
      child_category_names = parent_category_block.search('.category-list-individual-box-sub-category-name')
      child_category_blocks.each_with_index do |child_category_block, i| ## 子カテゴリの配列を回す。
        child_category = child_category_names[i].at('h4').inner_text
        @child_category = @parent_category.children.where(id: category_id, name: child_category).first_or_create ## 子カテゴリをcreate
        category_id += 1
        grandchild_category_blocks = child_category_block.search('.category-list-individual-box-sub-sub-category-name')
        grandchild_category_blocks.each do |grandchild_category_block| ## 孫カテゴリの配列を回す。
          grandchild_category = grandchild_category_block.at('a').inner_text
          ## squish = 先頭と末尾の改行やスペースなどを除去するメソッド
          next if grandchild_category.squish == "すべて" ## すべてはカテゴリーに含めない
          @grandchild_category = @child_category.children.where(id: category_id, name: grandchild_category.squish).first_or_create ## 孫カテゴリをcreate
          category_id += 1
        end
      end

    end
    return 0
  end

  def self.brands  ## ブランドのスクレイピング
    agent = Mechanize.new
    ## ↓スクレイピング用ページのファイル名を入れておく
    categories = ["autobike", "car_parts", "cosme", "domestic_car", "foods", "forign_car",
      "game", "instrument", "interior", "kids", "kitchen", "ladies", "mens", "phone", "sports", "watch"]

   categories.each_with_index do |category, i|
    current_page = agent.get("http://localhost:3000/items/scraping_#{category}")
    Scraping.get_brand(current_page)
   end
    return 0
  end

  def self.get_brand(page) ## 渡されたページ内のブランドを取得する
    brands = page.search(".brand-list-initial-box-brand-name")
    brands.each do |brand|
      @brand = Brand.where(name: brand.inner_text.squish).first_or_create
    end
  end

end