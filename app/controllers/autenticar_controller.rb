class AutenticarController < ApplicationController
  def index
    if cookies["autenticado"].present?
      begin
        secret_key = 'alunos_do_desafio'
        decoded_token = JWT.decode(cookies["autenticado"], secret_key, true, algorithm: 'HS256')
        valor = decoded_token.first
      
        @valor_loado = "O valor logado é (#{valor})"
      rescue
        delete_cookie
      end
    end
  end

  

  def signin
    aluno = Aluno.find_by(email: params[:login], password: params[:senha])
    
    if aluno.present? 
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
      redirect_to "/autenticar"
    end
  end
  def signout
    delete_cookie
    redirect_to "/"
  end


  private
  def delete_cookie
    cookies["autenticado"] = {
      value: "",
      expires: -1.minutes.from_now,
      secure: true,
      http_only: true,
    }
  end
end
