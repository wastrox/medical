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
end
