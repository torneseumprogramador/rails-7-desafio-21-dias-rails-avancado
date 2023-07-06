class AlunosController < ApplicationController
  layout "application_simples"

  def index

    ###### exemplo para criar usuários
    # 3.times do
    #   aluno = Aluno.create!(
    #     nome: Faker::Name.name,
    #     matricula: Faker::Number.unique.number(digits: 6).to_s,
    #     idade: Faker::Number.between(from: 18, to: 25),
    #     email: Faker::Internet.email
    #   )
    
    #   5.times do
    #     aluno.notas.create!(
    #       nota: Faker::Number.between(from: 0, to: 10),
    #       data: Faker::Date.between(from: 30.days.ago, to: Date.today)
    #     )
    #   end
    # end

    ###### exemplo para criar usuários
    # aluno = Aluno.new
    # aluno.nome = "Lucas"
    # aluno.save

    #### atualizar aluno
    # aluno = Aluno.find(params[:id])
    # aluno.nome = "Jardeu"
    # aluno.save

    #### excluir aluno
    # aluno = Aluno.find(params[:id])
    # aluno.destroy

    # baseado na doc https://chat.openai.com/share/1a5ab88e-8975-42c9-a2ec-12adfb5ad50a
    # faça todo o crud de alunos / notas em base de tudo que vc aprendeu anteriormente no desafio de rails https://www.torneseumprogramador.com.br/cursos/ruby_avancado/aulas
    # veja a aula de mongodb https://comunidadefechadatorneseumprog.club.hotmart.com/lesson/3ea5AL5Beg/23-or-aprendendo-banco-de-dados-nosql-cassandra-e-mongodb 
    # para que vc possa entender mais sobre normalização e denormalização
    # Mande um pull request para meu repo https://github.com/torneseumprogramador/rails-7-desafio-21-dias-rails-avancado

    @alunos = Aluno.all
    @alunos = @alunos.where(nome: /#{params[:nome]}/i) if params[:nome].present?
    @alunos = @alunos.where(idade: params[:idade].to_i) if params[:idade].present?

  end
end
