class ApplicationController < ActionController::Base
#   skip_before_action :verify_authenticity_token, if: :json_request?


  def after_sign_in_path_for(resource)
    debugger
    root_path
  end
end
