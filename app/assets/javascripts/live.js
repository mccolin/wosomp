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
      alert("AJAX load error");
    }
  });
}

/** Trigger a load for the next page in the navigation: **/
CURRENT_LIVE_TAB = -1;
function loadNextPage(callbackFn) {
  var $navMenu = $("#top-nav");
  var numTabs = $navMenu.find("li").length;
  var nextTabIdx = CURRENT_LIVE_TAB + 1;

  console.log("Within loadNextPage:");
  console.log("numTabs: "+numTabs);
  console.log("CURRENT_LIVE_TAB: "+CURRENT_LIVE_TAB);
  console.log("nextTabIdx: "+nextTabIdx);

  var $nextNav = $( $navMenu.find("li")[nextTabIdx] );

  console.log("nextNav:");
  console.log($nextNav);

  var $navLink = $nextNav.find("a").first();

  console.log("navLink:");
  console.log($navLink);

  CURRENT_LIVE_TAB = nextTabIdx;
  console.log("CURRENT_LIVE_TAB increased to "+CURRENT_LIVE_TAB);

  loadPage(
    $navLink.prop("href"),
    function(){
      setTimeout('loadNextPage()', 4000);
    }
  );




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
    $medalBar.css("width", parseInt(thisScore / totalScore * 100)+"%");
  });
  //console.log("Medal widths set");
}



$(function(){});
