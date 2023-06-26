namespace :desafio do
    desc "Esta rake foi criada no desafio de rails avançado e serve para escrever algo na tela"
    task mensagem_na_tela: :environment do
      Cliente.all.each do |cliente|
        puts "Id = #{cliente.id}"
        puts "Telefone = #{cliente.telefone}"
        puts "Valido para atualizar? = #{cliente.save}"
        
        # unless cliente.save
        #   debugger
        #   x = ""
        # end

        if cliente.telefone =~ /\A\(\d{2}\)\s\d{5}-\d{4}\z/
          puts "::: Telefone já formatado :::"
        else
          cliente.telefone = formatar_telefone(cliente.telefone)
          Cliente.where(id: cliente.id).update_all(telefone: cliente.telefone)
          puts "......... Atualizado ............."

          # if cliente.save
          #   puts "......... Atualizado ............."
          # else
          #   debugger
          #   puts cliente.errors
          # end
        end
      end
    end
end

namespace :desafio do
  desc "Duas rakes no mesmo arquivo"
  task mensagem_na_tela2: :environment do
    puts "Mostrando que posso ter 2 rakes no mesmo arquivo"
  end
end

def formatar_telefone(telefone)
  telefone = telefone.to_s.gsub(/\D/, '')  # Remove todos os caracteres não numéricos

  if telefone.length < 11
    telefone = telefone.rjust(11, '0')  # Completa com zeros à esquerda se necessário
  end

  telefone.gsub!(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')  # Aplica a máscara (00) 00000-0000

  telefone
end

  