document.observe("dom:loaded", function() {
    var mail_menu = $("email_issue_menu");
    if (mail_menu) {
        $$("div#content div.contextual a")[0].insert({before: mail_menu.remove().setStyle({display: "inline"}) });
    }
});
