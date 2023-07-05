class CsvClientes
  def self.processar(file)
    if File.exist?(file)
      CSV.foreach(file, headers: true) do |row|
          cliente_params = row.to_hash.slice('nome', 'telefone', 'endereco', 'ativo', 'email', 'created_at', 'updated_at')
          Cliente.create(cliente_params)
      end

      File.delete(file)
    end
  end
end