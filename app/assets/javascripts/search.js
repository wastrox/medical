$(document).ready(function(){
	//Убирает логотип и аватар если они пусты
	var img = $("img.photo-applicant, img.photo-employer");
	if (img.attr("alt") == "Missing") {
    	$(".logo-profile, .photo-profile").remove();
	}
	$("img").attr("alt", "Логотип");
	$("img.photo-applicant").attr("alt", "Фото профиля");
	
	// Удаляет контейнер с обложкой СЕО
	var img = $(".cover_news").attr("src");
	if (img == "/covers/index/missing.png") {
	    $(".cover_article_show_pag").css("display", "none");
	}
});
