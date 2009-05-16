module EzIssueSummariesHelper	 


 def find_issue(id = params[:id])
    @issue = Issue.find(id, :include => [:project, :tracker, :status, :author, :priority, :category])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end 

	def init_vars
		@errors = {} 
		@attributes = {}
	end
	
end
