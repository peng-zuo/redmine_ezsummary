class RedmineIssueSummaryListener < Redmine::Hook::ViewListener
  render_on :view_layouts_base_html_head, :inline => <<-END
		<% if controller.controller_name == "issues" && controller.action_name == "show" %>
			<%= javascript_include_tag 'issues/show.js', :plugin => 'redmine_ezsummary' %>
		    <%= stylesheet_link_tag 'issues/show.css', :plugin => 'redmine_ezsummary' %> 
        <% end %>
  END

  render_on :view_issues_show_details_bottom, :inline => <<-END
			<%= link_to_if_authorized t("label_ezsummary_mail"), { :controller => "ez_issue_summaries", :action => "new", :issue_id => issue},  :class => "icon icon-mail", :id => "email_issue_menu", :style => "display:none;" %>
  END
end