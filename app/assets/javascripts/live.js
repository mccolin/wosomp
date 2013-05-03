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

      $("#page-timer").removeClass("no-transition").css("width","100%");
    },
    error: function(xhr, status, msg){
      // console.log("Live page load error: ");
      // console.log(status);
      // console.log(msg);
    }
  });
  $("#page-timer").addClass("no-transition").css("width","0%");
}

/** Trigger a load for the next page in the navigation: **/
var NEXT_TAB_INDEX = 0;
var TIME_PER_PAGE = qsValue("t")[0] || 12500;
$("#page-timer").css({
  "-webkit-transition": "width "+TIME_PER_PAGE+"ms linear",
  "transition": "width "+TIME_PER_PAGE+"ms linear"
});
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

  // Set the team/athlete total widths according to their point totals:
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

    var $lastNonZeroBar = $totalBar.find(".bar[data-score!=0]").last();
    if (thisScore > 0 && $medalBar.is($lastNonZeroBar))
      $medalBar.css({"width":"100%", "float":"none"});
  });

}

/** Make API requests and load tweets and Instagram photos into UI: **/
function loadTweetsAndPhotos(instagramClientId) {
  var $content = $("#content");
  var $photoContainer = $content.find("#photos");
  var $tweetContainer = $content.find("#tweets");
  var hashtag = "wosomp";

  /** Load Tweets: **/
  $.getJSON("http://search.twitter.com/search.json?rpp=100&callback=?&q="+hashtag, function(data){
    for (var i=0; i < data.results.length; i++) {
      tweet = data.results[i];
      //console.log( tweet );
      var $tweetDiv = $(" \
        <div class='tweet media-object'> \
          <a href='http://twitter.com/"+tweet.from_user+"'><img class='pic' border='0' src='"+tweet.profile_image_url+"' width='50' height='60'/></a> \
          <a class='author' href='http://twitter.com/"+tweet.from_user+"'>"+tweet.from_user+"</a> \
          <span class='body'>"+formatTweet(tweet.text)+"</span> \
          <span class='time'>"+formatTwitterTime(tweet.created_at)+"</span> \
          <div style='clear:both;'></div> \
        </div>");
      $tweetContainer.append( $tweetDiv );
    }
    spinner.stop();
    $("p.lead").hide();
  });

  /** Load Instagram Photos: **/
  $.getJSON("https://api.instagram.com/v1/tags/"+hashtag+"/media/recent?client_id="+instagramClientId+"&callback=?", function(data){
    for (var i=0; i < data.data.length; i++) {
      var photo = data.data[i];
      //console.log(photo);
      var image = new Image();
      image.src = photo.images.low_resolution.url;
      var $photoDiv = $(" \
        <div class='photo media-object'> \
          <img src='"+photo.images.low_resolution.url+"'/> <br/>\
          <span class='name'>@"+photo.user.username+"</span> \
          <span class='caption'>"+(photo.caption ? photo.caption.text : "")+"</span> \
        </div>");
      $photoContainer.append( $photoDiv );
    }
    spinner.stop();
    $("p.lead").hide();
  });
}


/** Format tweet body with proper links: **/
function formatTweet(src) {
  var formatted = src.replace(/@(\w+)/g, function(str, uname){ return "<a href=\"https://twitter.com/"+uname+"\" target=\"_blank\">@"+uname+"</a>"});
  formatted = formatted.replace(/#(\w+)/g, function(str, hashtag){ return "<a href=\"https://twitter.com/search?q=%23"+hashtag+"&src=hash\" target=\"_blank\">#"+hashtag+"</a>"});
  return formatted;
}

/** Format the time of a tweet: **/
function formatTwitterTime(stamp) {
  var tweetTime = new Date(stamp);
  var nowTime = new Date();
  var diff = Math.floor((nowTime - tweetTime) / 1000);
  if (diff <= 60) return "just now";
  // if (diff < 20) return diff + " seconds ago";
  // if (diff < 40) return "half a minute ago";
  // if (diff < 60) return "less than a minute ago";
  if (diff <= 90) return "one minute ago";
  if (diff <= 3540) return Math.round(diff / 60) + " minutes ago";
  if (diff <= 5400) return "1 hour ago";
  if (diff <= 86400) return Math.round(diff / 3600) + " hours ago";
  if (diff <= 129600) return "1 day ago";
  if (diff < 604800) return Math.round(diff / 86400) + " days ago";
  if (diff <= 777600) return "1 week ago";
  return "on " + time;
}


/** Pull a value from the location querystring: **/
function qsValue(key) {
  var re=new RegExp('(?:\\?|&)'+key+'=(.*?)(?=&|$)','gi');
  var r=[], m;
  while ((m=re.exec(document.location.search)) != null) r.push(m[1]);
  return r;
}
