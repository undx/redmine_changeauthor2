# routes for change author
get 'changeauthor',      :to => 'changeauthor#index'
get 'changeauthor/edit', :to => 'changeauthor#edit'
put 'changeauthor/edit', :to => 'changeauthor#edit'
