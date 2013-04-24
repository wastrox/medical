$(document).ready(function(){
	//Убирает логотип и аватар если они пусты
	var img = $("img.photo-applicant, img.photo-employer");
	if (img.attr("alt") == "Missing") {
    	img.parent().remove();
	}
	$("img").attr("alt", "Логотип");
});
