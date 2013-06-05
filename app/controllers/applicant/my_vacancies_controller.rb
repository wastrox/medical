#encoding: utf-8
class Applicant::MyVacanciesController < ApplicationController
 layout "profile_applicant"

  def index
    @applicant = Applicant.find_by_salt(cookies[:salt])
  	@vacancies = @applicant.vacancy_responds
    @title = "Мои вакансии: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
end
