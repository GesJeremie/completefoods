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

  @collection_made_in.each do |made_in|
    xml.url do
      xml.loc "#{root_url}made-in-#{made_in}"
      xml.changefreq('daily')
      xml.priority '0.8'
    end

    xml.url do
      xml.loc "#{root_url}produced-in-#{made_in}"
      xml.changefreq('daily')
      xml.priority '0.8'
    end
  end

  @collection_made_by.each do |made_by|
    xml.url do
      xml.loc "#{root_url}made-by-#{made_by}"
      xml.changefreq('daily')
      xml.priority '0.8'
    end

    xml.url do
      xml.loc "#{root_url}produced-by-#{made_by}"
      xml.changefreq('daily')
      xml.priority '0.8'
    end
  end

  xml.url do
    xml.loc "#{root_url}suitable-for-vegans"
    xml.changefreq('daily')
    xml.priority '0.8'
  end

  xml.url do
    xml.loc "#{root_url}for-vegans"
    xml.changefreq('daily')
    xml.priority '0.8'
  end


end
