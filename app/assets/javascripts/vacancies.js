$(document).ready(function(){
	$('.timetable').click(function(){
    	$("#timetable_input").css("display", "none");
	});
	$('#timetable_radio_button').click(function(){
    	$("#timetable_input").css("display", "inline-block");
	});
});