// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// $('a[data-method="delete"]').live('ajax:success', function(){});
$(document).ready(function() {
/* Activating Best In Place */
$('.delete_post').live('ajax:success', function() {  
	$(this).parent().parent().fadeOut();
});
// $(document).bind('afterClose.facebox',function() {
	// $('.edit_post').live('ajax:success', function() {  
		// $(this).parent().parent().html($('.result').html());
	// });
// });
});
