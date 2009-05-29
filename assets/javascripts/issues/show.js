document.observe("dom:loaded",function(){
    $$("div#content div.contextual a")[0].insert({before: $("email_issue_menu").remove().setStyle({display: "inline"}) });
});
