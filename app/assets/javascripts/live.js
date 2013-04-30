/**
 * WOSoMP
 * Live / JavaScript
 *
**/


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
