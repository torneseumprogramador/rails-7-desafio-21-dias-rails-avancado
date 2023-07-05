require 'aws-sdk-sqs'

class SqsProducer
  def initialize(queue = "desafio-rails")
    sqs_config = Rails.application.config_for(:aws_sqs)
    @sqs = Aws::SQS::Client.new(
      access_key_id: sqs_config[:access_key],
      secret_access_key: sqs_config[:secret_key],
      region: sqs_config[:region]
    )
    @queue_url = @sqs.create_queue(queue_name: queue).queue_url
  end

  def produce(message)
    @sqs.send_message(queue_url: @queue_url, message_body: message)
  end
end
