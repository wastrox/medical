function workingNow(){ //по клику на чекбокс "Сейчас работаю здесь" скрывается поле даты *_till
 $(".current_workplace:checkbox").click(function(){
    var check = $(this).attr('checked');
    var parent_date = $(this).parent().parent().find(".month_till, .year_till");
    if (check == "checked") {
        $(parent_date).css('display', 'none');
    }
    else{
        $(parent_date).css('display', 'inline');
    }
 });
}

function workingNowCheck() { //проверка активных чекбоксов на странице
	
	var checkOn = $(".current_workplace:checkbox").attr("checked");
	var parent_date = $(".current_workplace:checkbox").parent().parent().find(".month_till, .year_till");
	if (checkOn == "checked") {
		$(parent_date).css('display', 'none');
	}else{
		$(parent_date).css('display', 'inline');
	}
};

$(function(){
	workingNowCheck(); // Временное решение для ТЕСТОВ, проверка активных чекбоксов "Сейчас работаю здесь"
	workingNow(); //по клику чекбокс "Сейчас работаю здесь" == checked -> удаляются формы Дата работы "_till"
});