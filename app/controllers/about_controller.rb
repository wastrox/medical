# encoding: utf-8
class AboutController < ApplicationController
layout "startpage"
skip_before_filter :require_login, :only => [:index]


  def index
	@vacancies = Vacancy.where(:state => "published").order("created_at desc").limit(7)
	@title = "О нас: работа в медицине. Сайт трудоустройства medical.netbee.ua"
	@description = "О компании Netbee. Самый большой выбор работы в медицине. Сайт трудоустройства medical.netbee.ua."
  end
end
