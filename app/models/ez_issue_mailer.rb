class IssueMailer < ActionMailer::Base
  def issue_summary(recv, thesubject, content)
    recipients recv
		from "peng.zuo@qq.com"
	  subject thesubject
	  sent_on Time.now
	  body content
  end

end
