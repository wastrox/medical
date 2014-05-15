#encoding: utf-8
module ApplicationHelper

  def active_tab(url) # This method is used in the layouts/_navbar_admin.html.erb for change class="active" in the navigation panel
    "active" if self.current_page?(url) # => <li class="active">
  end

  def month_helper
  	m = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
  	return m
  end

  def year_list_helper
  	year_list = Array.new
  	year = Time.now.year - 50
  	year.upto(Time.now.year) do	|i|
  		year_list << i
  	end
  	return year_list.reverse!
  end

  def company_name_helper
    sum = Company.where(:state => "pending").count
    sum == 0 ? name = "Компании" : name = "Компании(#{sum})"
    return name
  end

  def vacancy_name_helper
    sum = Vacancy.where(:state => "pending").count
    sum == 0 ? name = "Вакансии" : name = "Вакансии(#{sum})"
    return name
  end

  def resume_name_helper
    sum = Resume.where(:state => "pending").count
    sum == 0 ? name = "Резюме" : name = "Резюме(#{sum})"
    return name
  end

  def company_scope_helper(company)
    scope = company.scope.title
    scope == "Другое" ? scope = "Другая сфера деятельности" : scope
    return scope
  end

  def scope_translit_helper(company)
    scope = company.scope.title
    scope_translit = Russian.translit(scope).parameterize
    return scope_translit
  end

  def translate(date)
    name = Russian.translit(date).parameterize
  end

  def helper_short_email_of(current_user)
    s = current_user.email
    reg = /.*(?=@)/
    m = reg.match(s)
    return m.to_s
  end

  def salary_helper(object) # Если зарплата указана как 0(ноль) => puts "Не указано"
    salary_in = object.salary
    if salary_in != 0 
      salary_out = "#{salary_in} грн" 
    else 
      salary_out ="не указана" 
    end
    return salary_out
  end

  def translit_helper(str)
    Russian.translit(str).parameterize
  end

  def morpher_inflect_helper(str, type)
    begin
      array = Morpher.new(str)
      case type 
        when "scope"  
          return array.singular('где').mb_chars.downcase.to_s
        when "category" 
          return array.singular('Т').mb_chars.downcase.to_s
      end
    rescue
      return str
    end
  end
end
