/**
 * WOSoMP
 * Home / JavaScript
 *
**/

jQuery.fn.autolink = function () {
  return this.each( function(){
    var re = /((http|https|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
    $(this).html( $(this).html().replace(re, '<a href="$1">$1</a> ') );
  });
}

jQuery.fn.autoabbr = function () {
  return this.each( function(){
    $(this).html( $(this).html().replace(/(wosomp)/ig, "<abbr title=\"Weekend Olympic Showdown of Massive Proportions\">$1</abbr>"));
  });
}


$(function(){

  // Make the account indicator menu item a popover:
  $("#top-nav #link-account a").popover({placement:'bottom',trigger:'manual', content: $("#account-box-content").html() });
  $("#top-nav #link-account a").click(function(e){
    e.preventDefault();
    $(this).popover('toggle');
    return(false);
  });

});

