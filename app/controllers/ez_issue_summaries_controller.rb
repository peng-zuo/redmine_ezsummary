class EzIssueSummariesController < ApplicationController  
	unloadable
	helper :ez_issue_summaries
	include EzIssueSummariesHelper
	before_filter :find_issue, :only => [:show]
	
	def show    
		respond_to do |format|
			format.html { }
		end
	end
	                                          
	def email
		email_content = params[:content]
		email_recv = params[:recipients].split(/,|\s/)  
		EzContact.transaction do 
			email_recv.each do |recv|
				EzContact.create(:email => recv)
			end
		end
		
		    begin
		EzIssueMailer.deliver_issue_summary(email_recv, params[:subject], email_content)
	rescue   Exception => e
		puts e.to_s
	end
		flash[:notice] = "succ delivered"
		redirect_to "/issues"

	end
end
