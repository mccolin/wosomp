/**
 * WOSoMP
 * Olympiads / JavaScript
 *
**/

$(function(){

  /** When a user selects a team, note the selection on form: */
  $("#team-select").on("click", ".team button", function(e){
    var $button = $(this);
    var $teamWell = $button.parents(".team").first();
    var teamId = $teamWell.attr("data-team-id");
    var $hiddenTeamField = $("input#registration_team_id").first();
    $hiddenTeamField.val(teamId);

    $("#team-select .team").removeClass("selected").addClass("unselected");
    $teamWell.removeClass("unselected").addClass("selected");
  });

  /** On registration page, set all team select wells to same height: **/
  var tallestHeight = 0;
  $("#team-select .team.well").each(function(idx, el){
    if ( $(this).height() > tallestHeight ) { tallestHeight = $(this).height(); }
  });
  $("#team-select .team.well").css("min-height", tallestHeight);

  /** Trigger all date-pickers: **/
  $("input[data-type=date]").datepicker({
    format: "mm/dd/yyyy"
  });

  /** Trigger button-group radios: **/
  $("[data-toggle='buttons-radio'] button").button();


  /** Case-sensitive fields: **/
  $("[data-text-transform='uppercase']").on("change", function(e){
    $field = $(this);
    $field.val( $field.val().toUpperCase() );
  });

});



