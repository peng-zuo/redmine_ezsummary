module EzIssueSummariesHelper


  def find_issue(id = params[:issue_id])
    @issue = Issue.find(id, :include => [:project, :tracker, :status, :author, :priority, :category])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def init_vars
    @templates = User.current.ez_mail_templates
    @errors = {}
    @attributes = {}
    @html_title = [t("text_ezsummary_mail")]
  end

  def authored(created, author, options={})
    tag = distance_of_time_in_words(Time.now, created)
    time_tag = options[:plain] ? tag : content_tag('acronym', tag, :title => format_time(created))
    author_tag =  h(author || 'Anonymous')
    l(options[:label] || :label_added_time_by, :author => author_tag, :age => time_tag)
  end

  def render_mail_error(errors)
    return "" if errors.blank?
    error_messages = errors.map do |key, value|
      content_tag(:li, t(value))
    end.join()
    contents = ""
    contents << content_tag(:ul, error_messages)
    content_tag(:div, contents, :id => "errorExplanation", :class => "errorExplanation")
  end

end
