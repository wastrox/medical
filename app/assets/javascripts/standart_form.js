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
	        	$(dateTillEducation).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    	}
		});

		// Редактор для text_area в nested_form
		var wysihtml5 = field.find('.wysihtml5');

		$(wysihtml5).each(function(i, elem) {
		  $(elem).wysihtml5({
		    "font-styles": false, //Font styling, e.g. h1, h2, etc. Default true
		    "emphasis": true, //Italics, bold, etc. Default true
		    "lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
		    "html": true, //Button which allows you to edit the generated HTML. Default false
		    "link": false, //Button to insert a link. Default true
		    "image": false, //Button to insert an image. Default true,
		    "color": false //Button to change color of font  
		  });

		  $('[data-wysihtml5-command="bold"]').html("Ж");
		  $('[data-wysihtml5-command="italic"]').html("К");
		  $('[data-wysihtml5-command="underline"]').html("П");
		  $('[data-wysihtml5-command="insertUnorderedList"]').attr("title", "Список");
		  $('[data-wysihtml5-command="insertOrderedList"]').attr("title", "Нумерованный список");
		  $('[data-wysihtml5-command="Outdent"]').attr("title", "Обратный отступ");
		  $('[data-wysihtml5-command="Indent"]').attr("title", "Абзац");

		});
		//----------------------------------------------------------------------------------------

		//Ссылка "Загрузить картинку", admin/seo/scope/:id/edit, для nested_form :categories формы scope
		var uploadPhoto = field.find('a.upload-photo');
		var inputTypeFile = field.find('input[type=file]');
		$(uploadPhoto).click(function(){
			$(inputTypeFile).click();
		});
		$(inputTypeFile).change(function() {
				$(uploadPhoto).before('<p class="photo-msg"> Фото будет загружено после сохранения</p>');
		   		$(uploadPhoto).text("Изменить картинку");	
		});
		//----------------------------------------------------------------------------------------
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

	$('#add_education').click(function(){
		$('html').scrollTo('#add-education', 500);
	});

	$('#add_experience').click(function(){
		$('html').scrollTo('#add-experience', 1000);
	});

  	$("#phone").inputmask("mask", {"mask": "+" + "99(099) 999 99 99"});
  	$(".datepicker").inputmask("mask", {"mask": "99.99.9999"})

  	//  ------------------------------------------  Для ссылки Загрузать картинку или Загрузить фото -----------------------------------------------  	
  	$("a.upload-photo").click(function(){
  		$("#file").click();
	});

	//Для фотографии соискателя и работодателя
	$('form input[type=file]').change(function() {
	    var v = $("#file").val();
	    if (v != '' ) {
	        $(".photo-msg").remove();
	        $("#upload-photo-applicant").before('<p class="photo-msg"> Фото будет загружено после сохранения</p>');
			$("#upload-photo-applicant").text("Изменить фото");	
	        $("#upload-logo-company").before('<p class="photo-msg"> Логотип будет загружен после сохранения</p>');    
	   		$("#upload-logo-company").text("Изменить логотип");
			$("#upload-cover").before('<p class="photo-msg"> Фото будет загружено после сохранения</p>');
	   		$("#upload-cover").text("Изменить картинку");	
		}
	    else {
	    	$(".photo-msg").remove();
	        $(".upload-photo").before('<p class="photo-msg">Фото не выбрано</p>');
	    }
	});

	//Изменяет текст ссылки "Загрузить фото" на "Изменить фото", и для Профиля компании также.
	var imgPath = $('#image-path-photo').attr("src");
	var regText = /(missing)/i;
	if (imgPath != undefined) {
		if (imgPath.search(regText) == -1) {
	        $("#upload-photo-applicant").text("Изменить");
	    }
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------

	// Удаляет ссылки remove первых, обязательных, fields_for(Контактная информация компании)
	$("#contacts-company + .fields > a.red-link").remove();
	$("#contacts-company + .fields").css("margin-bottom", "15px");

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


    //Заменяет value чекбокса "Другой вариант"
	$("input").click(function() {
		var v = $("#timetable_input").val();
    	$("#timetable_radio_button").val(v);
	})

	//Окрашивает lable "Период работы" если данные не валидны
	$(".experience-date > .field_with_errors").parent().parent().parent().find(".period_of_work").css("color", "#FF7C86");
	//Окрашивает label "Персональные данные" если не валидно
	$("#personal-date > .field_with_errors").parent().find("label").css("color", "#FF7C86");

	//Автозаполнение для input Города в Резюме
		(function( $ ) {
			$.widget( "custom.combobox", {
				_create: function() {
				this.wrapper = $( "<span>" )
				.addClass( "custom-combobox" )
				.insertAfter( this.element );
				this.element.hide();
				this._createAutocomplete();
				this._createShowAllButton();
			},
			_createAutocomplete: function() {
				var selected = this.element.children( ":selected" ),
				value = selected.val() ? selected.text() : "";
				this.input = $( "<input>" )
				.appendTo( this.wrapper )
				.val( value )
				.attr( "title", "" )
				.addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
				.autocomplete({
					delay: 0,
					minLength: 0,
					source: $.proxy( this, "_source" )
				})
			.tooltip({
				tooltipClass: "ui-state-highlight"
			});
			this._on( this.input, {
				autocompleteselect: function( event, ui ) {
				ui.item.option.selected = true;
				this._trigger( "select", event, {
				item: ui.item.option
				});
				},
				autocompletechange: "_removeIfInvalid"
			});
		},
		_createShowAllButton: function() {
		var input = this.input,
		wasOpen = false;
		$( "<a>" )
		.attr( "tabIndex", -1 )
		//.attr( "title", "Show All Items" )
		.tooltip()
		.appendTo( this.wrapper )
		.button({
		icons: {
		primary: "ui-icon-triangle-1-s"
		},
		text: false
		})
		.removeClass( "ui-corner-all" )
		.addClass( "custom-combobox-toggle ui-corner-right" )
		.mousedown(function() {
		wasOpen = input.autocomplete( "widget" ).is( ":visible" );
		})
		.click(function() {
		input.focus();
		// Close if already visible
		if ( wasOpen ) {
		return;
		}
		// Pass empty string as value to search for, displaying all results
		input.autocomplete( "search", "" );
		});
		},
		_source: function( request, response ) {
		var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
		response( this.element.children( "option" ).map(function() {
		var text = $( this ).text();
		if ( this.value && ( !request.term || matcher.test(text) ) )
		return {
		label: text,
		value: text,
		option: this
		};
		}) );
		},
		_removeIfInvalid: function( event, ui ) {
		// Selected an item, nothing to do
		if ( ui.item ) {
		return;
		}
		// Search for a match (case-insensitive)
		var value = this.input.val(),
		valueLowerCase = value.toLowerCase(),
		valid = false;
		this.element.children( "option" ).each(function() {
		if ( $( this ).text().toLowerCase() === valueLowerCase ) {
		this.selected = valid = true;
		return false;
		}
		});
		// Found a match, nothing to do
		if ( valid ) {
		return;
		}
		// Remove invalid value
		this.input
		.val( "" )
		.attr( "title", value + " такого города нет в списке!" )
		.tooltip( "open" );
		this.element.val( "" );
		this._delay(function() {
		this.input.tooltip( "close" ).attr( "title", "" );
		}, 22500 );
		this.input.data( "ui-autocomplete" ).term = "";
		},
		_destroy: function() {
		this.wrapper.remove();
		this.element.show();
		}
		});
		})( jQuery );
		$(function() {
		$( "#combobox" ).combobox();
		$( "#toggle" ).click(function() {
		$( "#combobox" ).toggle();
		});
		});

});


// Bootstrap wysihtml5-toolbar edit, редактор текста;
$(document).ready(function(){

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5({
      "font-styles": false, //Font styling, e.g. h1, h2, etc. Default true
      "emphasis": true, //Italics, bold, etc. Default true
      "lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
      "html": true, //Button which allows you to edit the generated HTML. Default false
      "link": false, //Button to insert a link. Default true
      "image": false, //Button to insert an image. Default true,
      "color": false //Button to change color of font  
    });

    $('[data-wysihtml5-command="bold"]').html("Ж");
    $('[data-wysihtml5-command="italic"]').html("К");
    $('[data-wysihtml5-command="underline"]').html("П");
    $('[data-wysihtml5-command="insertUnorderedList"]').attr("title", "Список");
    $('[data-wysihtml5-command="insertOrderedList"]').attr("title", "Нумерованный список");
    $('[data-wysihtml5-command="Outdent"]').attr("title", "Обратный отступ");
    $('[data-wysihtml5-command="Indent"]').attr("title", "Абзац");
  });
});
//----------------------------------------------------------------------------------------

