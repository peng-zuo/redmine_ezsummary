var $j = jQuery.noConflict();

function fill_in(){
    var textarea = $j("#mail_content");
    var selected = $j("#templates option:selected");
    if (selected.val()) {
        textarea.val(textarea.val() + selected.val());
    }
}

function required_field(){
    $j("label.required").css("color", "rgb(72, 72, 72)").append($j("<span class='required'>*</span>"));
}

jQuery(document).ready(function() {
    $j("#recipients").autocomplete("/ez_contacts", {
        multiple: true
    });
    $j("#fill_in").click( fill_in );
    required_field();
});
