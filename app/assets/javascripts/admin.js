$(function () {
	$('.table_companies_index tr:first th, .table_companies_vacancy_index tr:first th').css('border-top', 'none');

	// admin/companies/vacancy/edit - Кнопка "Опубликовать" становится не активна если компания не прошла проверку модератором
	$(".disable").val("Компания не проверена").attr("disabled", "disabled");
});