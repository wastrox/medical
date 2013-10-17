$(function () {
	$('.table_companies_index tr:first th, .table_companies_vacancy_index tr:first th').css('border-top', 'none');

	// admin/companies/vacancy/edit - Кнопка "Опубликовать" становится не активна если компания не прошла проверку модератором
	$(".disable").val("Компания не проверена").attr("disabled", "disabled");

	// удаляет лишние категории в /admin/seo/scope/:id/edit
	$(".scope_form .fields").css("display", "none");

	//для раздела новости, скрывает описание главной новости
	$(function (checkbox){
	    var check = $(".default_news").prop("checked");
	    var description = $(".standart_form").find(".description");
	    if(check == true) {
	    	$(description).css("display", "block");
	    } else {
	    	$(description).css("display", "none");
	    }
	});

	$(".default_news").on("click", function(event){
	    var description = $(".standart_form").find(".description");
	    var check = $(this).prop("checked");
	    
	    if (check == false){
	        $(description).animate({ opacity: "0", height: 'toggle' }, 700);
	    }
	    else {
	        $(description).stop().animate({ opacity: "1", height: 'toggle' }, 1000);
	    }
	});
});