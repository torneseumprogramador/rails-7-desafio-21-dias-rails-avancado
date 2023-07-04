require 'kafka'

class KafkaConsumer
  def initialize
    kafka_config = Rails.application.config_for(:kafka)
    @kafka = Kafka.new(seed_brokers: kafka_config[:bootstrap_servers])
    @topic = kafka_config[:topic]
    @consumer = @kafka.consumer(group_id: 'desafio')  # Substitua pelo ID do grupo do consumidor que você deseja usar
  end

  def consume
    @consumer.subscribe(@topic)
    puts "Consumidor Kafka iniciado, aguardando mensagens"

    @consumer.each_message do |message|
      puts "Processando csv clientes no Kafka #{message.value}"
      CsvClientes.processar(message.value)
    end
  ensure
    @consumer.stop
  end
end
