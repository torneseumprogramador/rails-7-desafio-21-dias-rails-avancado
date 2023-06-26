namespace :inteligencia_artificial do
    desc "Esta rake o cliente vai digitar algo e eu pegarei este algo e irei pesquisar na API do Chat-GPT"
    task :pesquisa_chatgpt, [:pergunta] => :environment do |_, args|
      pergunta = args[:pergunta]

      if pergunta.blank?

        puts "Qual sua dúvida?"
        pergunta = STDIN.gets.chomp

        if pergunta.blank?
          puts "
          Passe sua pergunta no momento que executar a rake exemplo:
          rake inteligencia_artificial:pesquisa_chatgpt['Qual é a origem da vida']
          "
          exit
        end
      end

      # debugger

      resposta = fazer_pergunta(pergunta)
      
      puts "
      A resposta para sua dúvida foi: 
      #{resposta}
      "
    end
end

require 'openai'

def fazer_pergunta(pergunta)

  api_key = ENV['OPENAI_API_KEY']  # Substitua YOUR_API_KEY pela sua chave de API
  model = 'gpt-3.5-turbo-16k-0613'
  client = OpenAI::Client.new(access_token: api_key)

  response = client.chat(
    parameters: {
        model: model, # Required.
        messages: [{ role: "user", content: pergunta}]
  })

  if response["error"].present?
    return response["error"]["message"]
  end
  
  return response.choices[0].text.strip 
end
