root = "/var/www/project_libreria/current"
working_directory  root
pid "/var/www/project_libreria/shared/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.project_libreria.sock"
worker_processes 1
timeout 600

#before_exec do |_|
#    ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
#end
