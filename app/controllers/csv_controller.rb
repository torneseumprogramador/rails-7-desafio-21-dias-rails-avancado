require 'csv'
require 'fileutils'

class CsvController < ApplicationController
  def index

  end

  def upload
    file = params[:file]
    if file.present? && file.content_type == 'text/csv'
      # Thread.new do
      #   CSV.foreach(file.tempfile, headers: true) do |row|
      #     cliente_params = row.to_hash.slice('nome', 'telefone', 'endereco', 'ativo', 'email', 'created_at', 'updated_at')
      #     Cliente.create(cliente_params)
      #   end
      # end

      file_path = file.tempfile.path
      destination_dir = Rails.root.join('public')

      # Define o nome do arquivo de destino
      destination_file = File.join(destination_dir, file.original_filename)

      # Move o arquivo temporário para o diretório de destino
      FileUtils.mv(file_path, destination_file)

      # ClientesCsvWorker.perform_async(destination_file) # producer sidekiq
      # KafkaProducer.new.produce(destination_file) # producer kafka
      RabbitMqProducer.new.produce(destination_file) # producer rabbitMQ
      flash["notice"] = 'Estamos processando a informação!'
    else
      flash["error"] = 'Por favor, selecione um arquivo CSV válido.'
    end

    redirect_to "/csv"
  end
end
  