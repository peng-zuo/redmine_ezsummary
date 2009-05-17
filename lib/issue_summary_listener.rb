class RedmineIssueSummaryListener < Redmine::Hook::ViewListener
	render_on :view_layouts_base_html_head, :inline => <<-END
		<% if controller.controller_name == "issues" && controller.action_name == "show" %>
			<%= javascript_include_tag 'jquery', 'ez_mail', :plugin => 'redmine_ez_summary' %>
		    <%= stylesheet_link_tag 'ez_mail', :plugin => 'redmine_ez_summary' %> 
        <% end %>
	END
	
  render_on :view_issues_show_details_bottom, :inline => <<-END
		<div id="email_issue_menu" style="display:none;">
			<%= link_to_if_authorized t("ez_email"), { :controller => "ez_issue_summaries", :action => "new", :issue_id => issue}, :target => "_blank", :class => "icon icon-mail" %>
		</div>
  END
end