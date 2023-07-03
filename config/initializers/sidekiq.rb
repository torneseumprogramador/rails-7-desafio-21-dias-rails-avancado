Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }  # Configurar a URL do Redis aqui
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }  # Configurar a URL do Redis aqui
end
  