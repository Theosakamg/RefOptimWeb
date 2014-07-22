role :app, %w{analytics@imie}

server 'imie', user: 'analytics', roles: %w{web app}
set :deploy_to, "/home/analytics/"
set :branch, 'master'
