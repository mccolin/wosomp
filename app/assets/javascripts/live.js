/**
 * WOSoMP
 * Live / JavaScript
 *
**/

/** Load a page of the display into the viewport: **/
function loadPage(href, callbackFn) {
  jQuery.ajax(href, {
    type: "GET",
    url: href,
    success: function(html, status, xhr){
      $("#content").html(html);
      if (callbackFn)
        callbackFn();
    },
    error: function(xhr, status, msg){
      console.log("Live page load error: ");
      console.log(status);
      console.log(msg);
    }
  });
}

/** Trigger a load for the next page in the navigation: **/
var NEXT_TAB_INDEX = 0;
var TIME_PER_PAGE = 12000;
function loadNextPage(callbackFn) {
  var $navMenu = $("#top-nav");
  var $navItems = $navMenu.find("li");
  var $nextNav = $( $navItems[NEXT_TAB_INDEX] );
  var $nextLink = $nextNav.find("a").first();
  var nextCallbackFn = TAB_LOAD_CALLBACKS[NEXT_TAB_INDEX];

  loadPage(
    $nextLink.prop("href"),
    function(){
      $nextNav.addClass("active").siblings("li").removeClass("active");
      if (nextCallbackFn)
        nextCallbackFn();
      setTimeout('loadNextPage()', TIME_PER_PAGE);
    }
  );

  NEXT_TAB_INDEX += 1;
  if (NEXT_TAB_INDEX >= $navItems.length)
    NEXT_TAB_INDEX = 0;
}


/** Given the #id of a leaderboard, calculate and display it properly: */
function updateLeaderBoard(boardId) {
  var $board = $("#"+boardId);

  // Find the top score
  var topScore = 0;
  $board.find(".progress").each(function(idx, el){
    var thisScore = parseInt( $(this).attr("data-score") );
    if (thisScore > topScore) { topScore = thisScore; }
  });
  //console.log("Top score on the board: "+topScore);

  // Set the team total widths according to their point totals:
  $board.find(".progress").each(function(idx, el){
    var thisScore = parseInt( $(this).attr("data-score") );
    $(this).css("width", parseInt(thisScore / topScore * 100)+"%" );
  });
  //console.log("Team total widths set.");

  // Set the medal widths by score percentage:
  $board.find(".progress .bar").each(function(idx, el){
    var $medalBar = $(this);
    var $totalBar = $medalBar.parent();
    // var totalCount = parseInt( $totalBar.attr("data-count") );
    // var thisCount = parseInt( $medalBar.attr("data-count") );
    // $medalBar.css("width", parseInt(thisCount / totalCount * 100)+"%");
    var totalScore = parseInt( $totalBar.attr("data-score") );
    var thisScore = parseInt( $medalBar.attr("data-score") );
    var thisPct = parseInt(thisScore / totalScore * 100);
    $medalBar.css("width", thisPct+"%");
  });
  $board.find(".progress .bar:last-child").css({"width":"100%", "float":"none"});
  //console.log("Medal widths set");
}



$(function(){});
