# lib/tasks/generate_fake_data.rake

require 'faker'
require 'csv'

namespace :data do
  desc 'Generate fake data and export to CSV'
  task generate_fake_data: :environment do
    file_path = 'clients.csv'  # Substitua pelo caminho desejado para o arquivo CSV

    CSV.open(file_path, 'w', headers: true) do |csv|
      csv << ['nome', 'telefone', 'endereco', 'created_at', 'updated_at', 'ativo', 'email']
      
      1000.times do
        nome = Faker::Name.name
        telefone = Faker::PhoneNumber.phone_number
        endereco = Faker::Address.full_address
        created_at = Faker::Time.between(from: 2.years.ago, to: Time.current)
        updated_at = Faker::Time.between(from: created_at, to: Time.current)
        ativo = Faker::Boolean.boolean
        email = Faker::Internet.email

        csv << [nome, telefone, endereco, created_at, updated_at, ativo, email]
      end
    end

    puts "Arquivo CSV gerado em: #{file_path}"
  end
end