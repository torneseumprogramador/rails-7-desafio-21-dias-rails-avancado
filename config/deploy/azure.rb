server "20.231.97.244",
  user: "azureuser",
  roles: %w{web app},
  ssh_options: {
    user: "azureuser",
    keys: %w(/Users/danilo/Desktop/desafio-rails-avancado/azure_desafio.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }

set :deploy_to, '/home/azureuser/capistrano'