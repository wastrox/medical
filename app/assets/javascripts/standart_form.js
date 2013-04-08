// => FIXME: Объединить в отом файле все скрипты корорые были написаны для standart_form
$(document).on('nested:fieldAdded', function(event){
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

});
