// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//Sabrout_Start

// Search Bar

$(function()
{
	// Hide search wrap by default;
	$(".search-wrap").hide();

	$(".toggle-search").on("click", function(e) 
	{
		// Prevent default link behavior
		e.preventDefault();

		// Stop propagation
		e.stopPropagation();

		// Toggle search-wrap
		$(".search-wrap").slideToggle(300, function()
		{
			// Focus on the search bar
			// When animation is complete
			$("#search-bar").focus();	
		});
	});

	// Close the search bar if user clicks anywhere
	$(document).click(function(e)
	{
		var searchWrap = $(".search-wrap");
		
		if(!searchWrap.is(e.target) && searchWrap.has(e.target).length === 0)
		{
			searchWrap.slideUp(300);	
		}
	});    
});
 

//Sabrout_End	

 function test() {
 	var e = document.getElementById('desc');
 	if(e.className === 'invisible'){
 		e.className = 'shop-description';
 	}
 	else{
	e.className = 'invisible';
	}
}

