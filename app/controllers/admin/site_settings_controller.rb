class Admin::SiteSettingsController < Admin::BaseController
  include ThemesManagementHelper
  before_filter :get_settings
  before_filter :get_themes, :only => [:edit, :choose_theme]

  protected
  def get_settings
    @settings = settings # This is defined in site_settings_helper
  end

  def get_themes
    @themes = list_themes
  end

  public
  def show
  end

  def edit
  end

  def update
    if @settings.update_attributes(params[:site_setting])
      flash[:notice] = "Site Settings were updated successfully."
      redirect_to :action => 'show'
    else
      flash.now[:error] = "There was a problem updating the site settings."
      render :action => 'edit'
    end
  end

  def choose_theme
    if params[:theme]
      if @themes.include?(params[:theme])
        @settings.user_theme_name = params[:theme]
        @settings.save
        flash[:notice] = "The theme has been changed to #{params[:theme]}"
        redirect_to :action => 'choose_theme'
      else
        flash.now[:error] = "The theme selected doesn't seem to be installed.  This is an error."
        render :action => 'choose_theme'
      end
    else
      # Render the listing to choose from
    end
  end
end
