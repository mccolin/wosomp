/**
 * WOSoMP
 * Results / JavaScript
 *
 * Loaded in Admin layer for behaviors associated with assigning
 * Result data for Regisrations and Teams in an Olympiad
 *
**/

$(function(){

  /** When an icon is selected, denote it as such: */
  //$(".result-icon").not(".selected").on("click", function(e){
  $("#participant-select").on("click", ".result-icon:not(.selected)", function(e){
    var $icon = $(this);
    $icon.addClass("selected").attr("data-selected", true);
    // console.log("Selected result icon:");
    // console.log($icon);
  });

  /** When an icon is de-selected, denote is as such: */
  //$(".result-icon.selected").on("click", function(e){
  $("#participant-select").on("click", ".result-icon.selected", function(e){
    var $icon = $(this);
    $icon.removeClass("selected").removeAttr("data-selected");
    // console.log("Unselected result icon:");
    // console.log($icon);
  });

  /** When an award-assign button is clicked, assign all selected
   ** icons to the award category: **/
  $(".btn-assign").on("click", function(e){
    var $button = $(this);
    var $zone = $button.parents(".zone");
    var $form = $button.parents("form").first();
    var $selectedIcons = $(".result-icon[data-selected]");

    var awardType = $button.attr("data-award");

    $selectedIcons.each( function(idx, el){
      var $icon = $(this);
      var regId = $icon.attr("data-registration") || null;
      var teamId = $icon.attr("data-team");
      var formValue = awardType+"-"+teamId+"-"+regId;

      $zone.append( $icon.clone() );
      $form.append("<input type=\"hidden\" name=\"results[awards][]\" value=\""+formValue+"\"/>");
    });

    // Unselect all icons and start fresh after assigning:
    $(".result-icon.selected").removeClass("selected").removeAttr("data-selected");

  });



});

