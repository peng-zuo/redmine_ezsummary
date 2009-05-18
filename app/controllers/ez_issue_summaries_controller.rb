class EzIssueSummariesController < ApplicationController
  unloadable
  helper :ez_issue_summaries
  include EzIssueSummariesHelper
  before_filter :find_issue, :init_vars, :authorize

  layout "ez_base"

  def new  
    respond_to do |format|
      format.html { }
    end
  end

  def create
    [:content, :recipients, :subject].each do |var|
      @attributes[var] = params[var]
    end

    @journals = @issue.journals.find(:all, :include => [:user, :details], :order => "#{Journal.table_name}.created_on ASC")
    @journals.each_with_index {|j, i| j.indice = i+1}
    @journals.reverse! if User.current.wants_comments_in_reverse_order?

    recipients = @attributes[:recipients].split(/,|\s/)
    @errors.merge! EzContact.import_contacts(*recipients)

    [:content, :subject, :recipients].each do |key|
      @errors.merge! key => "ez_#{key}_error" if @attributes[key].blank?
    end

    User.current.ez_mail_templates.create(:content => @attributes[:content]) if params[:save_flag] == "1"

    if @errors.empty?
      begin
        EzIssueMailer.deliver_issue_summary(recipients, @attributes[:subject], @attributes[:content], @issue, @journals)
        flash[:notice] = t('ez_issue_mail_succ')
        respond_to do |format|
          format.html { redirect_to url_for(:controller => "issues", :action => "show", :id => @issue) }
          format.js { render :template => "ez_issue_summaries/success", :layout => false }
        end
        return
      rescue Exception => e
        @errors.merge! :unknown => "ez_unknown_error"
      end
    end
    respond_to do |format|
      format.html { render :action => "new" }
      format.js { render :template => "ez_issue_summaries/fail", :layout => false }
    end

  end
end
