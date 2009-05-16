class RedmineIssueSummaryListener < Redmine::Hook::ViewListener
	render_on :view_layouts_base_html_head, :inline => <<-END
		<% if controller.controller_name == "issues" && controller.action_name == "show" %>
			<%= javascript_include_tag 'jquery', 'issue_summary', :plugin => 'redmine_ez_summary' %>
		<% end %>
	END
	
  render_on :view_issues_show_details_bottom, :inline => <<-END
		<div id="email_issue_menu" style="display:none;" class="icon" >                     
			<%= link_to t("ez.email"), ez_issue_summary_path(issue),:target => "_blank" %>
		</div>                                                           
	END
end