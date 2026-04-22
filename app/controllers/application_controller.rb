class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout "design_system"

  include GDS::SSO::ControllerMethods
  include TokenHelper

  def token_bypass?
    valid_compare_preview_jwt?(bypass_params[:token], Request.most_recent_for_source(source_app: bypass_params[:source_app], source_id: bypass_params[:source_id]))
  end

  def bypass_params
    params.permit(:source_app, :source_id, :token)
  end
end
