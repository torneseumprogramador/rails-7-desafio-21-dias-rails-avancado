class LoginController < ApplicationController
  def index
    cookie_teste = cookies["teste"]

    if cookie_teste.present?
      @retono = "Cookie gravado"
    else
      @retono = "cookie não gravado"
      cookies["teste"] = {
        value: "desafio rails",
        expires: 30.minutes.from_now,
        secure: true,
        http_only: true,
      }
    end


    if cookies["autenticado"].present?
      begin
        secret_key = 'alunos_do_desafio'
        decoded_token = JWT.decode(cookies["autenticado"], secret_key, true, algorithm: 'HS256')
        valor = decoded_token.first
      
        @valor_loado = "O valor logado é (#{valor})"
      rescue
        cookies["autenticado"] = {
          value: "",
          expires: -1.minutes.from_now,
          secure: true,
          http_only: true,
        }
      end
    end
  end

  def sair
    cookies["autenticado"] = {
      value: "",
      expires: -1.minutes.from_now,
      secure: true,
      http_only: true,
    }

    redirect_to "/"
  end

  def acao_login
    # aluno = Aluno.where(login: params[:login], senha: params[:senha]).first
    # if aluno.present? 
    #   cookies["autenticado"] = {
    #     value: params[:login],
    #     expires: 30.minutes.from_now,
    #     secure: true,
    #     http_only: true,
    #   }

    #   redirect_to "/"
    # else
    #   flash[:error] = "Login ou senha inválidos"
    #   redirect_to "/login"
    # end

    if params[:login] == "alunos" and params[:senha] == "desafio"

      secret_key = 'alunos_do_desafio'
      valor = JWT.encode(params[:login], secret_key, 'HS256')

      cookies["autenticado"] = {
        value: valor,
        expires: 30.minutes.from_now,
        secure: true,
        http_only: true,
      }

      redirect_to "/"
    else
      flash[:error] = "Login ou senha inválidos"
      redirect_to "/login"
    end
  end
end
