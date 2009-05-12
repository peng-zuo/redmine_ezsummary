ActionController::Routing::Routes.draw do |map|    
	map.resources :issue_summaries
	map.resource :contacts, :controller => "contacts"
end