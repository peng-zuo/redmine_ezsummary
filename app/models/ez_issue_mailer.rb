class EzIssueMailer < ActionMailer::Base
	helper :custom_fields
  helper :application
	include Redmine::I18n
	
	include CustomFieldsHelper
	include ApplicationHelper

	self.view_paths.unshift File.join(Rails.configuration.plugin_paths[0], "redmine_ez_summary", "app", "views")
	
 	def self.default_url_options
		Mailer.default_url_options
  end
		
	
  def issue_summary(recv, thesubject, content, issue)

    recipients recv
		from "peng.zuo@qq.com"
	  subject thesubject
	  sent_on Time.now       

  	body 	:issue => issue,
					:content => content,
					:issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue)
  end

	def render_message(method_name, body)                   
		layout = method_name.to_s.match(%r{text\.(html|xml)}) ? 'layout.text.html.rhtml' : 'layout.text.plain.rhtml'  
		mailer_view_root = File.join(template_root, "mailer")
    body[:content_for_layout] = render(:file => method_name, :body => body  ) 
		# plugin_path = File.join(Rails.configuration.plugin_paths[0], "redmine_ez_summary", "app", "views")
		root_view_path = self.class.view_paths.last
    ActionView::Base.new( root_view_path, body, self).render(:file => "mailer/#{layout}" , :use_full_path => true)
	end
		
end                               
