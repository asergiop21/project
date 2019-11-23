#set path to the application
app_dir= "/opt/project"
shared_dir = "#{app_dir}/shared/tmp"
working_directory "#{app_dir}/current"

# Set unicorn options
worker_processes 2
preload_app true
timeout 3000

# Path for the Unicorn socket
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Set path for logging
stderr_path "/opt/project/shared/log/unicorn.stderr.log"
stdout_path "/opt/project/shared/log/unicorn.stdout.log"

# Set proccess id path
pid "#{shared_dir}/pids/unicorn.pid"                                            
