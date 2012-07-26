require 'redmine'

Redmine::Plugin.register :redmine_changeauthor do

  name 'Redmine ChangeAuthor plugin'
  author 'Tom Stark @fragtom'
  description 'Plugin for author change'
  version '0.0.2' 
  settings :default => {'redmine_changeauthor_log_setting' => 'no'}, :partial => 'settings/redmine_changeauthor_settings'

  requires_redmine :version_or_higher => '2.0.0'

  project_module :issue_tracking do
    permission :change_author, :require => :member
  end
end

