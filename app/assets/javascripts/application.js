// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery_ujs
//= require_tree .

function highlightOverId()
{
	if(typeof $.cookie('overId') == undefined)
		return;

	var comp = parseInt($.cookie('overId'));

	$(".beer-id").each(function(ix, elm) {
    	a = parseInt($(elm).text());
    	if (a > comp)
    		$(elm).addClass("beer-id-over");
    });
}

function undoHighlightOverId()
{
	$(".beer-id-over").each(function(ix, elm) {
    	$(elm).removeClass("beer-id-over");
    });
}

$(function() {
	$( "#browar" ).autocomplete({
	        source: "/breweries/autocomplete",
	        minLength: 2});

    $('#shown').change(function() {
        this.form.submit();
    });

    if(typeof $.cookie('showOverId') == undefined)
    {
    	$.cookie('showOverId', 'false', {expires: 360});
    	$.cookie('overId', '0', {expires: 360});
    }

    if($.cookie('showOverId') == 'true')
    	highlightOverId();
    
    $(document).keypress( function(event) 
    {
    	if(event.shiftKey)
    	{
    		if(event.which == 123)
    		{
    			$.cookie('showOverId', 'true', {expires: 360});
    			highlightOverId();
    		}

    		if(event.which == 125)
    		{
    			$.cookie('showOverId', 'false', {expires: 360});
    			undoHighlightOverId();
    		}

    		if(event.which == 124)
    		{
    			$.cookie('showOverId', 'true', {expires: 360});
    			val = prompt("Highlight beers over this ID:", $.cookie("overId"));
    			if(val != null)
    			{
    				$.cookie('overId', val, {expires: 360});
    				highlightOverId();
    			}
    		}
    	}

	if(event.ctrlKey && event.which == 106)
	{ 
		console.log(event.which);	
		return false;
}
    });
});
