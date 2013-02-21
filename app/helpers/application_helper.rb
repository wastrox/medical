module ApplicationHelper
  def active_tab(url) # This method is used in the layouts/_navbar_admin.html.erb for change class="active" in the navigation panel
    "active" if self.current_page?(url) # => <li class="active">
  end
end
