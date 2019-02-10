xml.instruct!

xml.urlset(xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9') do
  xml.url do
    xml.loc root_url
    xml.changefreq("hourly")
    xml.priority "1.0"
  end

  @products.each do |product|
    xml.url do
      xml.loc product_url(product)
      xml.changefreq('daily')
      xml.priority '0.8'
      xml.lastmod product.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%2N%:z')
    end
  end

  @collections.each do |collection|
    xml.url do
      xml.loc collection_url(collection.slug)
      xml.changefreq('daily')
      xml.priority '0.8'
    end
  end

  @brands.each do |brand|
    xml.url do
      xml.loc brand_url(brand)
      xml.changefreq('daily')
      xml.priority '0.8'
    end
  end

end
