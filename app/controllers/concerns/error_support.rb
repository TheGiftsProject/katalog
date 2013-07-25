module ErrorSupport

  def forbidden
    respond_to do |format|
      format.html {
        flash[:error] = t('errors.unauthorized')
        redirect_to :root
      }
      format.all { render :nothing, :status => :forbidden }
    end
  end

end