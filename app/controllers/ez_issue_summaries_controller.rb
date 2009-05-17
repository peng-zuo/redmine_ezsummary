class EzIssueSummariesController < ApplicationController
  unloadable
  helper :ez_issue_summaries
  include EzIssueSummariesHelper
  before_filter :find_issue, :init_vars, :authorize

  layout "ez_base"

  def new
    @templates = User.current.ez_mail_templates
    respond_to do |format|
      format.html { }
    end
  end

  def create
    @templates = User.current.ez_mail_templates
    [:content, :recipients, :subject].each do |var|
      @attributes[var] = params[var]
    end

    @journals = @issue.journals.find(:all, :include => [:user, :details], :order => "#{Journal.table_name}.created_on ASC")
    @journals.each_with_index {|j, i| j.indice = i+1}
    @journals.reverse! if User.current.wants_comments_in_reverse_order?


    @errors.merge! EzContact.import_contacts(*@attributes[:recipients].split(/,|\s/))

    [:content, :subject, :recipients].each do |key|
      @errors.merge! key => "ez_#{key}_error" if @attributes[key].blank?
    end

    if (params[:save_flag] == "1")
      User.current.ez_mail_templates.create(:content => @attributes[:content])
    end
    if @errors.empty?
      begin
        EzIssueMailer.deliver_issue_summary(@attributes[:recipients].split(/,|\s/), @attributes[:subject], @attributes[:content], @issue, @journals)
        flash[:notice] = t('ez_issue_mail_succ')
        respond_to do |format|
          format.html { redirect_to url_for(:controller => "issues", :action => "show", :id => @issue) }
          format.js { render :template => "ez_issue_summaries/success", :layout => false }#{ render :json => {:success => "ok" } }
        end
        return
      rescue Exception => e
        puts e.to_s
        @errors.merge! :unknown => "ez_unknown_error"
      end
    end
    respond_to do |format|
      format.html { render :action => "new" }
      format.js { render :json => {:success => "error" } }
    end

  end
end
