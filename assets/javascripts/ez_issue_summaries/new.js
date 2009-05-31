function fill_in() {
    var textarea = $("#mail_content");
    var selected = $("#templates option:selected");
    if(selected.val() != undefined){
        textarea.val(textarea.val() + selected.val());
    }
}

$(function() {
    $("#recipients").autocomplete("/ez_contacts", {
        multiple: true
    });
    $("#fill_in").click(fill_in);
});
