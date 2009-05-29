function fill_in() {
    var textarea = $("#mail_content");
    textarea.val(textarea.val() + $("#templates option:selected").val());
}

$(function() {
    $("#recipients").autocomplete("/ez_contacts", {
        multiple: true
    });
    $("#fill_in").click(fill_in);
});
