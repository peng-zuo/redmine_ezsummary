require 'redmine'
require_dependency 'issue_summary_listener'

Redmine::Plugin.register :redmine_issue_summary do
  name 'Redmine Issue Summary plugin'
  author 'Peng Zuo'
  description 'Send Issue Summary Emails'
  version '0.0.1'
end
                     
