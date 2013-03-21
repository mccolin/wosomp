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

    var teamShirtColor = $teamWell.attr("data-shirt-color");
    $("#shirt img").removeClass("selected");
    $("#shirt img.shirt-"+teamShirtColor).addClass("selected");
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

  /** Based on current user selections, calculate and update the registration fee
   ** displayed on the form: **/
  function updateFeeAndToggleFields() {
    var $regAthleteToggle = $("#registration_athlete_true");
    var $regSupporterToggle = $("#registration_athlete_false");
    var $optInShirtToggle = $("#registration_uniform_shirt_true");
    var $optOutShirtToggle = $("#registration_uniform_shirt_false");

    var regFee = 0;
    if ($regAthleteToggle.is(":checked")) {
      regFee += parseInt($regAthleteToggle.attr("data-fee"));
      $optInShirtToggle.prop("checked",true);
    }
    else {
      regFee += parseInt($regSupporterToggle.attr("data-fee"));
      if ($optInShirtToggle.is(":checked")) { regFee += parseInt($optInShirtToggle.attr("data-fee")); }
      else { regFee += parseInt($optOutShirtToggle.attr("data-fee")); }
    }

    $("#waiver-fee-amount").html( "$"+regFee );

    if ($regAthleteToggle.is(":checked")) {
      $(".spectator-only").slideUp( function(){ $(".athlete-only, .shirt-only").slideDown(); });
    }
    else {
      $(".athlete-only").slideUp( function(){
        $(".spectator-only").slideDown();
        if ($optInShirtToggle.is(":checked"))
          $(".shirt-only").slideDown();
        else
          $(".shirt-only").slideUp();
      });

    }
  }

  /** When users toggle fee-respective settings, update appropriate items on the page: **/
  $("#registration_athlete_true, #registration_athlete_false, #registration_uniform_shirt_true, #registration_uniform_shirt_false").on("click", updateFeeAndToggleFields);
  updateFeeAndToggleFields();



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



