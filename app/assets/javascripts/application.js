

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
 
// Log In form

