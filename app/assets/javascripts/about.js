$(document).ready(function(){
	$(".boxed-nav .line-bottom:last-child").remove();

	$("#frame a[href^='http://']").attr("target","_blank");
});