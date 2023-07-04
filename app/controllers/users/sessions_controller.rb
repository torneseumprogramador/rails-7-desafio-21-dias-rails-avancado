class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    # debugger
    "/clientes" # a url que ele precisa enviar ao entrar
    # root_path # a url que ele precisa enviar ao entrar
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    # respond_to do |format|
    #   format.all { head :no_content }
    #   debugger
    #   format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: Devise.responder.redirect_status }
    # end

    redirect_to after_sign_out_path_for(resource_name), status: Devise.responder.redirect_status
  end

  # def after_sign_out_path_for(resource_or_scope)
  #   debugger
  #   "/clientes" # a url que ele precisa enviar ao sair
  # end
end