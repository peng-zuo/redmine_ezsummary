class EzIssueMailer < Mailer #ActionMailer::Base
  helper :ez_issue_summaries

  # self.template_root = ActionController::Base.view_paths.first

  include EzIssueSummariesHelper



  def issue_summary(recv, thesubject, content, issue, journals)
    redmine_headers 'Project' => issue.project.identifier,
                    'Issue-Id' => issue.id,
                    'Issue-Author' => issue.author.login
    
    recipients recv
    subject thesubject
    body    :issue => issue,
            :content => content,
            :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue),
            :journals => journals
    content_type "multipart/alternative"

    part "text/plain" do |p|
      p.body = render_message("issue_summary.text.plain.rhtml", body)
    end

    part "text/html" do |p|
      p.body = render_message("issue_summary.text.html.rhtml", body)
    end            
  end

#  def render_message(method_name, body)
#    layout = method_name.to_s.match(%r{text\.(html|xml)}) ? 'layout.text.html.rhtml' : 'layout.text.plain.rhtml'
#
#    body[:content_for_layout] = render(:file => method_name, :body => body  )
#    root_view_path = File.join( RAILS_ROOT, "app", "views")
#    ActionView::Base.new( root_view_path, body, self).render(:file => "mailer/#{layout}", :use_full_path => true)
#  end

end                               
