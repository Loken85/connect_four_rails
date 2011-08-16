class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #allows controllers to use authenticate
  
end
