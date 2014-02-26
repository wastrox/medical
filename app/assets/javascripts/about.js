$(document).ready(function(){
	$(".boxed-nav .line-bottom:last-child").remove();

	$("#frame a[href^='http://']").attr("target","_blank").attr("rel","nofollow");
	$(".news_url").attr("target","_self");
});