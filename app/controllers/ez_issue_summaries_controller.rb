class EzIssueSummariesController < ApplicationController  
	unloadable
	helper :ez_issue_summaries
	include EzIssueSummariesHelper
	before_filter :find_issue, :only => [:show]
	                                                  
	layout "ez_base"
	def show                                 
		@templates = User.current.ez_mail_templates    
		respond_to do |format|
			format.html { }
		end
	end
	                                          
	def email
		find_issue(params[:issue_id])
		email_content = params[:content]
		email_recv = params[:recipients].split(/,|\s/)
		
#		@journals = @issue.journals.find(:all, :include => [:user, :details], :order => "#{Journal.table_name}.created_on ASC")
#    @journals.each_with_index {|j,i| j.indice = i+1}
#    @journals.reverse! if User.current.wants_comments_in_reverse_order?
		
	  
		EzContact.import_contacts(email_recv)
		
		if(params[:save_flag] == "1")
			User.current.ez_mail_templates.create(:content => email_content)
		end
		
		begin
			EzIssueMailer.deliver_issue_summary(email_recv, params[:subject], email_content, @issue)
			flash[:notice] = t('ez.issue_mail_succ')  
			redirect_to url_for(:controller => "issues", :action => "show", :id => @issue)
	 	rescue
			flash[:error] = t("ez.issue_mail_error")
			render :action => "show"
		end
	end
end
