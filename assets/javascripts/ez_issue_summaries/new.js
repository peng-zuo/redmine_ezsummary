var $j = jQuery.noConflict();
jQuery(document).ready(function() {
    $j("#recipients").autocomplete("/ez_contacts", {
        multiple: true
    });
    $j("#fill_in").click(function() {
        var textarea = $j("#mail_content");
        var selected = $j("#templates option:selected");
        if (selected.val()) {
            textarea.val(textarea.val() + selected.val());
        }
    });
});
