# Author::    Paweł J. Wal

# Just an exception to be thrown around
class UnAuth < StandardError; end

# Application controller
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RoutingError, :with => :render_404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from UnAuth, :with => :render_403

  # Raises not found errors in case a route is not matched.
  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

	protected

  # Very simple auth function
	def authenticate
	  authenticate_or_request_with_http_basic do |username, password|
	  	if (username == Beeronrails::Application.config.user && password == Beeronrails::Application.config.pass)
	  		true
	    else
	    	raise UnAuth
	    end
	  end
	end
	
 private
  # Renders my 404 message
  def render_404(exception = nil)
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  # Renders 403 message
  def render_403(exception = nil)
    render :file => "#{Rails.root}/public/sadcat.html", :status => 403, :layout => false
  end  	
end
