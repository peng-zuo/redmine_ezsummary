require 'redmine' 
require 'dispatcher'
require_dependency 'issue_summary_listener'   
require_dependency 'user'
require 'user_patch'

Redmine::Plugin.register :redmine_ez_summary do
  name 'Redmine Issue Summary plugin'
  author 'Peng Zuo'
  description 'Send Issue Summary Emails'
  version '0.0.1'
end

Dispatcher.to_prepare do                        
	User.send(:include, PengZuo::UserPatch)
end