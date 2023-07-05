require 'rest-client'
require 'json'

class AzureBusConsumer
  def initialize(queue_name="desafio-rails")
    sqs_config = Rails.application.config_for(:azure_service_bus)
    @queue_url = "https://desafio-rails.servicebus.windows.net/#{queue_name}"
    @tenant_id = sqs_config[:tenant_id]
    @client_id = sqs_config[:client_id]
    @client_secret = sqs_config[:client_secret]
  end

  def consume
    puts 'Service Bus consumer iniciado, aguardando mensagens'

    loop do
      response = RestClient.get(@queue_url + '/messages/head', { 'Authorization' => access_token })
      if response.code == 200
        message = JSON.parse(response.body)

        puts "Processando mensagem: #{message['messageId']}"
        # Implement your message processing logic here

        delete_message(message['messageId'])
      else
        sleep 5
      end
    end
  end

  private

  def delete_message(message_id)
    RestClient.delete("#{@queue_url}/messages/#{message_id}", { 'Authorization' => access_token })
  end

  def access_token
    token_url = "https://login.microsoftonline.com/#{@tenant_id}/oauth2/token"

    response = RestClient.post(token_url, {
      grant_type: 'client_credentials',
      client_id: @client_id,
      client_secret: @client_secret,
      resource: 'https://servicebus.azure.net/'
    })

    token = JSON.parse(response.body)['access_token']

    "Bearer #{token}"
  end
  
end