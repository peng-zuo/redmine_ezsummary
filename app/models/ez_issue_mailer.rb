class EzIssueMailer < ActionMailer::Base
  helper :custom_fields
  helper :application
  helper :issues
  helper :ez_issue_summaries
  include Redmine::I18n

  self.template_root = ActionController::Base.view_paths.last

  include IssuesHelper
  include CustomFieldsHelper
  include ApplicationHelper
  include EzIssueSummariesHelper

  def self.default_url_options
    Mailer.default_url_options
  end


  def issue_summary(recv, thesubject, content, issue, journals)
    recipients recv
    subject thesubject
    sent_on Time.now

    body    :issue => issue,
            :content => content,
            :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue),
            :journals => journals
  end

  def render_message(method_name, body)
    layout = method_name.to_s.match(%r{text\.(html|xml)}) ? 'layout.text.html.rhtml' : 'layout.text.plain.rhtml'

    body[:content_for_layout] = render(:file => method_name, :body => body  )
    root_view_path = File.join( RAILS_ROOT, "app", "views")
    ActionView::Base.new( root_view_path, body, self).render(:file => "mailer/#{layout}", :use_full_path => true)
  end

end                               
