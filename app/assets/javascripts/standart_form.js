// => FIXME: Объединить в отом файле все скрипты корорые были написаны для standart_form
$(document).on('nested:fieldAdded', function(event){

		// Удаляет ссылки remove первых, обязательных, fields_for(Опыт работы, Образование)
		//$("#experience + .fields > a.red-link, #education + .fields > a.red-link").remove();
		
		//Окрашивает lable "Период работы" если данные не валидны
		$(".experience-date > .field_with_errors").parent().parent().parent().find(".period_of_work").css("color", "#FF7C86");

		var field = event.field; 
		var dateTillExperience = field.find('.date-till');
		var checkboxExperience = field.find('.current_workplace');

		$(checkboxExperience).click(function() {
			if (this.checked) {				
	        	$(dateTillExperience).animate({ opacity: "0", height: 'toggle' }, 700);
	    	}
	    	else{
	        	$(dateTillExperience).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    	}
		});

		var dateTillEducation = field.find('.dateTillEducation');
		var checkboxEducation = field.find('.student_now');

		$(checkboxEducation).click(function() {
			if (this.checked) {				
	        	$(dateTillEducation).animate({ opacity: "0", height: 'toggle' }, 700);
	    	}
	    	else{
	        	//$(dateTillEducation).css('display', 'block');
	        	$(dateTillEducation).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    	}
		});
});	

$(document).on('nested:fieldRemoved', function(event){
	var field = event.field; 
	var itemContactCompany = field.find('.item');
	var input = field.find('.item > .field > input');

	$(".remove-link-contact-company").click( function() {
		//itemContactCompany.remove();
		input.remove();
	});
});

$(document).ready(function(){
  	$("#phone").inputmask("mask", {"mask": "(099) 999 99 99"});
  	$("a.upload-photo").click(function(){
  		$("#file").click();
	});

		// Удаляет ссылки remove первых, обязательных, fields_for(Опыт работы, Образование)
		//$("#experience + .fields > a.red-link, #education + .fields > a.red-link").remove();

  	// Удаляет пустой тег img (когда нет логотипа компании или фотографии соискателя), пустой тег img ломает верстку
	var img = $("#image-path-photo").attr("src");
	if (img == "/photos/small/missing.png") {
	    $("#image-path-photo").css("display", "none");
	}
	else if (img == "/logos/small/missing.png") {
	    $("#image-path-photo").css("display", "none");
	}

	// Удаляет ссылки remove первых, обязательных, fields_for(Контактная информация компании)
	//$("#contacts-company + .fields > a.red-link").remove();
	//$("#contacts-company + .fields").css("margin-bottom", "15px");

	//Условие стиля для чекбокса "Защита персональных данных" на странице резюме
	$("#personal-date .field_with_errors").css("display", "inline-block");


	//Скрипт для страницы employer/vacancies/new for radiobutton
	var timetable = $("#timetable_radio_button").is(":checked");

	if (timetable == true){
			$("#timetable_input").css("display", "block")
		}
	else {
			$("#timetable_input").css("display", "none")
		}

		$(".timetable").click(function() {

			var otherOver = $("#timetable_radio_button").is(":checked");

			if (otherOver == true) {				
	        	$("#timetable_input").stop().animate({ opacity: "1", height: 'toggle' }, 500);				
	    	}
	    	else{
	        	$("#timetable_input").css("display", "none")
	    	}
		});

	//Для ссылки "Сохранить" на панели навигации
	$(".save-link").click( function() {
    	 $(".btn-warning").click();
	});

	//Для "Сейчас работаю здесь" и "Еще учусь" на странице resumes/:id/edit, скрывает select с датами
	$(function (checkbox){
	    var check = $("input:checkbox:checked")
	    var parent_date = $(check).parent().parent().find(".date-till, .dateTillEducation");
	    $(parent_date).css("display", "none");
	});

	$(".current_workplace").on("click", function(event){
	    var parent_date = $(this).parent().parent().find(".date-till");
	    var check = $(this).prop("checked");
	    
	    if (check == true){
	        $(parent_date).animate({ opacity: "0", height: 'toggle' }, 700);
	    }
	    else {
	        $(parent_date).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    }
	});

	$(".student_now").on("click", function(event){
	    var parent_date = $(this).parent().parent().find(".dateTillEducation");
	    var check = $(this).prop("checked");
	    
	    if (check == true){
	        $(parent_date).animate({ opacity: "0", height: 'toggle' }, 700);
	    }
	    else {
	        $(parent_date).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    }
	});

	//Для фотографии соискателя и работодателя
	$('form input[type=file]').change(function() {
	    var v = $("#file").val();
	    if (v != '' ) {
	        $(".photo-msg").remove();
	        $(".upload-photo").before('<p class="photo-msg"> Фото будет загружено после сохранения</p>');
	        $(".upload-photo").text("Изменить фото");
	    }
	    else {
	    	$(".photo-msg").remove();
	        $(".upload-photo").before('<p class="photo-msg">Фото не выбрано</p>');
	    }
	});

	//Изменяет текст ссылки "Загрузить фото" на "Изменить фото"
	var image = $('#image-path-photo').attr("src");
    if (image != '/photos/small/missing.png' ) {
        $(".upload-photo").text("Изменить фото");
    }

    //Заменяет value чекбокса "Другой вариант"
	$("input").click(function() {
		var v = $("#timetable_input").val();
    	$("#timetable_radio_button").val(v)
	})

	//Окрашивает lable "Период работы" если данные не валидны
	$(".experience-date > .field_with_errors").parent().parent().parent().find(".period_of_work").css("color", "#FF7C86");
	//Окрашивает label "Персональные данные" если не валидно
	$("#personal-date > .field_with_errors").parent().find("label").css("color", "#FF7C86");

	//Убирает логотип и аватар если они пусты
	var img = $("img.photo-applicant");
	if (img.attr("alt") == "Missing") {
    	img.parent().remove();
	}
});