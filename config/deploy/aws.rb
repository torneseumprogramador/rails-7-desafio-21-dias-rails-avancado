server "ec2-54-157-254-100.compute-1.amazonaws.com",
  user: "ubuntu",
  roles: %w{web app},
  ssh_options: {
    user: "ubuntu",
    keys: %w(/Users/danilo/Desktop/desafio-rails-avancado/aws_desafio.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }

set :deploy_to, '/home/ubuntu/capistrano'