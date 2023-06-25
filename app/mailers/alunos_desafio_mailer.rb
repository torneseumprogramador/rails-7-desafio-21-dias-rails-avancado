class AlunosDesafioMailer < ApplicationMailer
    def email_de_boas_vindas(cliente)
        @cliente = cliente
        mail(to: @cliente.email, subject: 'Bem-vindo a aplicação do desafio de rails avançado')
    end
end
