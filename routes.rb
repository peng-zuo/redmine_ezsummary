ActionController::Routing::Routes.draw do |map|
  map.resource :ez_contacts, :controller => "ez_contacts", :only => [:show]
  map.resource :ezsummary, :path_prefix => "/issues/:issue_id", :controller => "ez_issue_summaries", :only => [:new, :create]
end