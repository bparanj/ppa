require 'paypal-sdk-permissions'

class PermissionsController < ApplicationController
  def show
    api = PayPal::SDK::Permissions::API.new

    # Build request object
    permissions_request = api.build_request_permissions
    permissions_request.scope    = ["EXPRESS_CHECKOUT"]
    permissions_request.callback = "http://localhost:3055/samples/permissions/get_access_token"

    # Make API call & get response
    permissions_response = api.request_permissions(permissions_request)

    # Access Response
    permissions_response.response_envelope
    @token = permissions_response.token
  end
  
  def get_access_token
    api = PayPal::SDK::Permissions::API.new

    # Build request object
    token_request = api.build_get_access_token
    token_request.token     = params["request_token"]     if params["request_token"]
    token_request.verifier  = params["verification_code"] if params["verification_code"]

    # Make API call & get response
    token_response = api.get_access_token(token_request)

    # Access Response
    token_response.response_envelope
    token_response.error
    
    logger.info("Token is : #{token_response.token}")
    logger.info("Token secret is : #{token_response.token_secret}")
  end
  
end
