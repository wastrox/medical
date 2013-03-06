module Admin::AccountsHelper
  
  def helper_link(i)
    account = Account.find_by_id(i)
    link = case
              when account.employer? then edit_admin_companies_profile_path(account.company.id)
              when account.applicant? then edit_admin_resume_path(account.resume.id)
           else
              "#"
           end
    return link
  end
  
end
