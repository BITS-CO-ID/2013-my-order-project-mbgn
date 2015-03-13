$(window).load(function() {
	// SUSTITUTE FOR CSS FIRST-AND LAST-CHILD
	$('.class-name li').last().css('margin-right',0);
	
	// INPUT FIELD AUTO CLEAR

	
	// PAGE LOADING
	$(".loading").fadeOut(function(){
		setTimeout(function(){$(".loading").remove(); },2000);
		$('body').removeClass('hide');
	});
	
		//
	$('.menu li').mouseenter(function(){
		$('ul',this).slideDown();
	});
	
	$('.menu li').mouseleave(function(){
		$('ul',this).stop(true,true).slideUp('fast');
	});
	
	
	
});