class ChangeauthorController < ApplicationController
  unloadable
  layout 'admin'

  def index
    @issue=Issue.find_by_id(params[:issue_id])
    @project = Project.find(@issue.project_id)
    @users = @project.member_principals.find(:all,
                                             :include    => [:roles, :principal],
                                             :order      => "firstname",
                                             :conditions => "#{Principal.table_name}.type='User'")
    @issue_user=User.find(@issue["author_id"])
  end

  def edit
    @issue = Issue.find_by_id(params[:issue_id])
    old_user = @issue.author
    new_user = User.find params[:authorid]
    if @issue.update_attribute(:author_id, params[:authorid])
      flash[:notice] = l(:notice_successful_update)
      # user hook
      call_hook(:controller_redmine_changeauthor_edit_after_save, :author => new_user, :old_author => old_user, :issue => @issue)
      # log replacement into journal
      if Setting['plugin_redmine_changeauthor']['redmine_changeauthor_log_setting']=='yes'
        @issue.init_journal(User.current, l(:log_entry_author_changed, :old_user => old_user, :new_user => new_user)).save
      end

      redirect_to :controller => "issues", :action => "show", :id => params[:issue_id]
    else
      redirect_to :controller => "changeauthor", :action => "edit", :id => params[:issue_id]
    end
  end
end
