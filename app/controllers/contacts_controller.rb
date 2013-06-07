# encoding: utf-8
class ContactsController < ApplicationController
layout "startpage"
skip_before_filter :require_login, :only => [:index]

  def index
	@vacancies = Vacancy.where(:state => "published").order("created_at desc").limit(3)
	@title = "Контакная информация: работа в медицине. Сайт трудоустройства medical.netbee.ua"
  end
end
