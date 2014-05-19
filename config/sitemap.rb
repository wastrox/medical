Sitemap::Generator.instance.load :host => "medical.netbee.ua" do


  def translit_castom(str)
    return Russian.translit(str).parameterize
  end

  # Sample path:
  #   path :faq
  # The specified path must exist in your routes file (usually specified through :as).

  # Sample path with params:
  #   path :faq, :params => { :format => "html", :filter => "recent" }
  # Depending on the route, the resolved url could be http://mywebsite.com/frequent-questions.html?filter=recent.

  # Sample resource:
  #   resources :articles

  # Sample resource with custom objects:
  #   resources :articles, :objects => proc { Article.published }

  # Sample resource with search options:
  #   resources :articles, :priority => 0.8, :change_frequency => "monthly"

  # Sample resource with block options:
  #   resources :activities,
  #             :skip_index => true,
  #             :updated_at => proc { |activity| activity.published_at.strftime("%Y-%m-%d") }
  #             :params => { :subdomain => proc { |activity| activity.location } }
  
  path :root, :priority => 1
  literal "/sitemap"
  literal "/contacts/index"
  literal "/personal_data/index"
  literal "/about"
  literal "/companies"
  
  
  Resume.where(:state => ["published", "hot"]).each do |resume|
    literal "/search/resume/#{resume.to_param}"
  end

  Vacancy.where(:state => ["published", "hot"]).each do |vacancy|
    literal "/#{Russian.translit(vacancy.city).parameterize}/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"
  end

  Scope.all.each do |scope|
    literal "/vacancy/#{translit_castom(scope.title)}"
  end

  Company.where(:state => ["published", "vip"]).each do |company|
    literal "/company/#{company.to_param}"
  end

  Category.all.each do |category|
    literal "/vacancy/#{Russian.translit(category.scope.title).parameterize}/#{Russian.translit(category.name).parameterize}"
  end

  Article.where(:state => ["default", "published"]).each do |article|
    literal "/news/#{article.to_param}"
  end

  City.all.each do |city|
    translit_city = translit_castom(city.name)
    literal "/#{translit_city}/vacancy/" 
    Scope.all.each do |scope|
      literal "/#{translit_city}/vacancy/#{translit_castom(scope.title)}"
      Category.all.each do |category|
        literal "/#{translit_city}/vacancy/#{translit_castom(scope.title)}/#{translit_castom(category.name)}"
      end
    end
  end
end
