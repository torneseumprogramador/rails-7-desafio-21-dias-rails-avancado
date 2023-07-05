require 'rest-client'
require 'json'

class AzureBusProducer
  def initialize(queue_name="desafio-rails")
    sqs_config = Rails.application.config_for(:azure_service_bus)
    @queue_url = "https://desafio-rails.servicebus.windows.net/#{queue_name}"
    @tenant_id = sqs_config[:tenant_id]
    @client_id = sqs_config[:client_id]
    @client_secret = sqs_config[:client_secret]
  end

  def produce(message)
    headers = {
      'Authorization' => access_token,
      'Content-Type' => 'application/json'
    }

    payload = {
      message: message
    }.to_json

    RestClient.post(@queue_url + '/messages', payload, headers)
  end

  private

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
