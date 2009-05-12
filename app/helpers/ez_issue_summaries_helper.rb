module EzIssueSummariesHelper	 
 def find_issue
    @issue = Issue.find(params[:id], :include => [:project, :tracker, :status, :author, :priority, :category])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
