Sitemap::Generator.instance.load :host => "medical.netbee.ua" do

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
  literal "/contacts/index"
  literal "/personal_data/index"
  literal "/about"
  
  
  Resume.search.each do |resume|
    literal "/search/resume/#{resume.to_param}"
  end

  Vacancy.search.each do |vacancy|
    literal "/vacancy/#{Russian.translit(vacancy.category.scope.title).parameterize}/#{Russian.translit(vacancy.category.name).parameterize}/#{vacancy.to_param}"
  end

  Company.search.each do |company|
    literal "/search/company/#{company.to_param}"
  end

  Scope.all.each do |scope|
    literal "/vacancy/#{Russian.translit(scope.title).parameterize}"
  end

  Category.all.each do |category|
    literal "/vacancy/#{Russian.translit(category.scope.title).parameterize}/#{Russian.translit(category.name).parameterize}"
  end
end
