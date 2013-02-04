class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  
  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translations not available"
      end
    end
  end
  
  def default_url_options
    {:locale => I18n.locale}
  end
end
