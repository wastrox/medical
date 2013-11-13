$(document).ready(function(){
	//Убирает логотип и аватар если они пусты
	var img = $("img.photo-applicant, img.photo-employer");
	if (img.attr("alt") == "Missing") {
    	$(".logo-profile, .photo-profile").remove();
	}
	$("img").attr("alt", "Логотип");
	$("img.photo-applicant").attr("alt", "Фото профиля");
	
	// Удаляет контейнер с обложкой СЕО
	var img = $(".cover_news");
	var regText = /(missing)/i;
	var imgPath = img.attr("src");
	if (img.is(".cover_news") == true) {
		if (imgPath.search(regText) != -1) {
		    $(".cover_article_show_pag").css("display", "none");
		}
	}
});
