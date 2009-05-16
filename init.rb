require 'redmine' 
require 'dispatcher'
require_dependency 'issue_summary_listener'   
require_dependency 'user'
require 'user_patch'
require 'action_mailer_patch'

Redmine::Plugin.register :redmine_ez_summary do
  name 'Redmine Issue Summary plugin'
  author 'Peng Zuo'
  description 'Send Issue Summary Emails'
  version '0.0.1'

  project_module :issue_tracking do
    permission :ez_send_mail, :ez_issue_summaries =>  [:show, :email]
  end
  
end
Dispatcher.to_prepare do                        
	User.send(:include, PengZuo::UserPatch)
end
ActionMailer::Base.__send__ :include, PengZuo::ActionMailerPatch
