ActionController::Routing::Routes.draw do |map|    
  map.resource :ez_contacts, :controller => "ez_contacts"
  map.resource :ez_mail, :path_prefix => "/issues/:issue_id", :controller => "ez_issue_summaries", :only => [:new, :create]
end