require 'omniauth'
require 'omniauth/strategies/oauth'

module OmniAuth
  module Strategies
    class Garmin < OmniAuth::Strategies::OAuth

      option :name, "garmin"

      option :client_options, {
        scheme: :body,
        site: 'https://connect.garmin.com',
        request_token_path: 'http://connectapi.garmin.com/oauth-service-1.0/oauth/request_token',
        access_token_path: 'http://connectapi.garmin.com/oauth-service-1.0/oauth/access_token',
        authorize_url: 'http://connect.garmin.com/oauthConfirm'
      }

      uid do
        access_token.token
      end

      info do
        {
          name: access_token.token
        }
      end

      def request_phase
        request_token = consumer.get_request_token({}, options.request_params)

        session['oauth'] ||= {}
        session['oauth'][name.to_s] = {'callback_confirmed' => request_token.callback_confirmed?, 'request_token' => request_token.token, 'request_secret' => request_token.secret}

        callback_url = options.oauth_callback

        if request_token.callback_confirmed?
          redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url))
        else
          redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url))
        end

      rescue ::Timeout::Error => e
        fail!(:timeout, e)
      rescue ::Net::HTTPFatalError, ::OpenSSL::SSL::SSLError => e
        fail!(:service_unavailable, e)
      end
    end
  end
end
