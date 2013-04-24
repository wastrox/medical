$(document).ready(function(){
	//Убирает логотип и аватар если они пусты
	$("img").attr("alt", "Логотип");
	
	var img = $("img.photo-applicant");
	if (img.attr("alt") == "Missing") {
    	img.parent().remove();
	}
});
