$(document).ready(function(){
	$('.timetable').click(function(){
    	$("#timetable_input").css("display", "none");
	});
	$('#timetable_radio_button').click(function(){
    	$("#timetable_input").css("display", "inline-block");
	});
	
		 $("#e2_2").select2({
			placeholder: "Select a State",
			width: "315px"
		});
});