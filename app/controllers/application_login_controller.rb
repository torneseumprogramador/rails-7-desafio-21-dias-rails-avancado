class ApplicationLoginController < ApplicationController
  # # before action do devise
  before_action :authenticate_user!

  # # before action feito em aula
  # before_action :verificar_autenticacao


  # def verificar_autenticacao
  #   if cookies["autenticado"].blank?
  #     redirect_to "/"
  #   end
  # end
end
