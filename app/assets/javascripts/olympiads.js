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

    updateShirt($("canvas#shirt-designer"), {
      color: $teamWell.attr("data-shirt-color")
    });
  });

  /** On registration page, set all team select wells to same height: **/
  var tallestHeight = 0;
  $("#team-select .team, .teams .team").each(function(idx, el){
    if ( $(this).height() > tallestHeight ) { tallestHeight = $(this).height(); }
  });
  $("#team-select .team, .teams .team").css("min-height", tallestHeight+"px");

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


  /** Trigger any canvas shirt elements on the page: */
  $("canvas[data-shirt-preview]").each(function(el, idx){
    drawShirt( $(this) );
  });


  /** Update the name on the shirt design: **/
  $("#registration_uniform_name").on("change", function(e){
    var $nameField = $(this);
    var $shirtDesigner = $("canvas#shirt-designer");
    updateShirt($shirtDesigner, {name: $nameField.val()} );
  });

  /** Update the number on the shirt design: **/
  $("#registration_uniform_number").on("change", function(e){
    var $numField = $(this);
    var $shirtDesigner = $("canvas#shirt-designer");
    updateShirt($shirtDesigner, {number: $numField.val()} );
  });


  /** When captain is editing team shirt, update colors: */
  $("select#team_shirt_color").on("change", function(e){
    var $select = $(this);
    $("canvas.shirt-preview").each(function(idx, el){
      updateShirt($(this), {color: $select.val()});
    });

  });

  /** Allow teammembers to preview each other's shirts on the Registration review page: **/
  $("div.athlete-icon.previewable").on("click", function(e){
    var $icon = $(this);
    var $shirtPreview = $("canvas#shirt-preview");
    updateShirt($shirtPreview, {
      name: $icon.find(".name").first().html(),
      number: $icon.find(".number").first().html()
    });
  });


  /** Apply any tooltips: **/
  if ( $().tooltip )
    $("[data-toggle='tooltip']").tooltip();


  /** Activate any tabs: **/
  $("#tab-navigation a").click(function(e){
    e.preventDefault();
    $(this).tab("show");
  });

  /** Trigger any color selectors on the page: **/
  if ( $().colorpicker ) {
    $("#team_color1_code").colorpicker().on("changeColor", function(ev){
      $("#team-colors-preview").css("background-color", ev.color.toHex());
    });
    $("#team_color2_code").colorpicker().on("changeColor", function(ev){
      $("#team-colors-preview").css("color", ev.color.toHex());
    });
  }


});


/*
<canvas
  data-shirt-image="/assets/shirts/purple.jpg"
  data-shirt-name="MCCOLIN"
  data-shirt-number="88"
  data-shirt-preview="true"
  height="285"
  width="300">
</canvas>
*/

function drawShirt(canvas) {
  // Capture the canvas and its context, cleared:
  var canvasEl = canvas.get(0);
  var c = canvasEl.getContext("2d");
  c.clearRect(0, 0, canvasEl.width, canvasEl.height);

  // Load the data properties from this canvas tag:
  var shirtName = canvas.attr("data-shirt-name");
  var shirtNumber = canvas.attr("data-shirt-number");
  var fontSizeName = shirtName.length <= 9 ? "35px" : "27px";   // << Make responsive to canvas dimensions
  var shirtImage = new Image();
  shirtImage.onload = function() {
    c.drawImage(this,0,0,canvasEl.width,canvasEl.height);
    c.fillStyle = "#FFF";
    c.font = "normal "+fontSizeName+" CollegeRegular,sans-serif";
    c.textAlign = "center";
    c.textBaseline = "middle";
    c.fillText(shirtName, 150, 60);
    c.font = "normal 150px CollegeRegular,sans-serif";
    c.fillText(shirtNumber, 150, 140);
  }
  shirtImage.src = canvas.attr("data-shirt-image");
}

function updateShirt(canvas, opts) {
  opts = opts || {};
  if (opts.name)
    canvas.attr("data-shirt-name", opts.name);
  if (opts.number)
    canvas.attr("data-shirt-number", opts.number);
  if (opts.color)
    canvas.attr("data-shirt-image", "/assets/shirts/"+opts.color+".jpg");
  drawShirt(canvas);
}

function openShirtImage(canvas) {
  var canvasEl = canvas.get(0);
  window.open(canvasEl.toDataURL("image/png"));
}

