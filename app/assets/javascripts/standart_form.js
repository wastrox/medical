// => FIXME: Объединить в отом файле все скрипты корорые были написаны для standart_form
$(document).on('nested:fieldAdded', function(event){

		// Удаляет ссылки remove первых, обязательных, fields_for(Опыт работы, Образование)
		$("#experience + .fields > a.red-link, #education + .fields > a.red-link").remove();

		var field = event.field; 
		var dateTillExperience = field.find('.date-till');
		var checkboxExperience = field.find('.current_workplace');

		$(checkboxExperience).click(function() {
			if (this.checked) {				
	        	$(dateTillExperience).animate({ opacity: "0", height: 'toggle' }, 700);
	    	}
	    	else{
	        	$(dateTillExperience).animate({ opacity: "1", height: 'toggle' }, 1000);
	    	}
		});

		var dateTillEducation = field.find('.dateTillEducation');
		var checkboxEducation = field.find('.student_now');

		$(checkboxEducation).click(function() {
			if (this.checked) {				
	        	$(dateTillEducation).animate({ opacity: "0", height: 'toggle' }, 700)
	    	}
	    	else{
	        	//$(dateTillEducation).css('display', 'block');
	        	$(dateTillEducation).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    	}
		});
});	

$(document).ready(function(){
  	$("#phone").inputmask("mask", {"mask": "+(999) 999 99 99"});
  	$("a.upload-photo").click(function(){
  		$("#file").click();
	});

  	// Удаляет пустой тег img (когда нет логотипа компании или фотографии соискателя), пустой тег img ломает верстку
	var img = $("#image-path-photo").attr("src");
	if (img == "/photos/small/missing.png") {
	    $("#image-path-photo").css("display", "none");
	}
	else if (img == "/logos/small/missing.png") {
	    $("#image-path-photo").css("display", "none");
	}

	// Удаляет ссылки remove первых, обязательных, fields_for(Контактная информация компании)
	$("#contacts-company + .fields > a.red-link").remove();
	$("#contacts-company + .fields").css("margin-bottom", "15px");

});
