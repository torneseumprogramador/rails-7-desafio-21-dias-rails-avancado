class ApplicationLoginController < ApplicationController
  before_action :verificar_autenticacao


  def verificar_autenticacao
    if cookies["autenticado"].blank?
      redirect_to "/"
    end
  end
end
