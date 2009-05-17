class EzContactsController < ApplicationController
  unloadable

  def show
    @contacts = EzContact.find(:all, :conditions => [ "email like ?", "#{params[:q]}%"], :limit => params[:limit] || 10 ) \
.map {|c| c.email }

    respond_to do |format|
      format.js {
        render :json => @contacts.join("\n")
      }
    end
  end
end
