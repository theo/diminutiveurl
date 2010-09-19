set :application, "diminutiveurl.com"

set :user, "apps"

set :scm_username, "theo"
set :scm_password, Proc.new { Capistrano::CLI.password_prompt("SVN password for #{scm_username}, please: ") }
set :repository, Proc.new { "--username #{scm_username} --password #{scm_password} --no-auth-cache http://notedpath.unfuddle.com/svn/notedpath_diminutiveurl/trunk" }

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/apps/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion

role :app, "diminutiveurl.com"
role :web, "diminutiveurl.com"
role :db,  "diminutiveurl.com", :primary => true

set :use_sudo, false

set :deploy_via, :copy

set :runner, "deploy"

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"