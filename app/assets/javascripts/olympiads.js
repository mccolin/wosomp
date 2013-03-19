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
    format: "yyyy-mm-dd",
    viewMode: "years"
  });

  /** Trigger button-group radios: **/
  $("[data-toggle='buttons-radio'] button").button();

  /** Case-sensitive fields: **/
  $("[data-text-transform='uppercase']").on("change", function(e){
    $field = $(this);
    $field.val( $field.val().toUpperCase() );
  });


  /** Set the shirt container to the height of the shirt: **/
  function shirtResize() {
    $shirtContainer = $("#shirt");
    if ($shirtContainer)
      $shirtContainer.height( $shirtContainer.find("img").first().height() );
  }
  $(window).on("resize", shirtResize); // function(e){ shirtResize(); });
  $("#shirt img").on("load", shirtResize)
  shirtResize();

  /** Update the name on the shirt design: **/
  function updateShirtName(name) {
    if (name) {
      $shirtContainer = $("#shirt");
      $shirtContainer.find("span.name").first().html(name);
    }
  }
  $("#registration_uniform_name").on("change", function(e){ updateShirtName($(this).val()); });
  $("#registration_uniform_name").change();

  /** Update the number on the shirt design: **/
  function updateShirtNumber(num) {
    if (num) {
      $shirtContainer = $("#shirt");
      $shirtContainer.find("span.number").first().html(num);
    }
  }
  $("#registration_uniform_number").on("change", function(e){ updateShirtNumber($(this).val()); });
  $("#registration_uniform_number").change();

});



