require 'csv'

class ClientesCsvWorker
    include Sidekiq::Worker
  
    def perform(file)
        if File.exist?(file)
            CsvClientes.processar(file)
        end
    end
  end
  