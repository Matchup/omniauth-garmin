require 'omniauth'
require 'omniauth/strategies/oauth'

module OmniAuth
  module Strategies
    class Garmin < OmniAuth::Strategies::OAuth

      p "class level variables"

      option :name, "garmin"

      option :client_options, {
        scheme: :body,
        site: (ENV['GARMIN_CONNECT_API_URL'] || 'http://connectapitest.garmin.com'),
        request_token_path: '/oauth-service-1.0/oauth/request_token',
        access_token_path: '/oauth-service-1.0/oauth/access_token',
        authorize_url: (ENV['GARMIN_CONNECT_URL'] || 'http://connecttest.garmin.com') + '/oauthConfirm',
        request_params: 'http://localhost:3000'
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
        p "in request_phase"

        request_token = consumer.get_request_token({:oauth_callback => "http://localhost:3000" }, options.request_params)
        session['oauth'] ||= {}
        session['oauth'][name.to_s] = {'callback_confirmed' => request_token.callback_confirmed?, 'request_token' => request_token.token, 'request_secret' => request_token.secret}

        if request_token.callback_confirmed?
          redirect request_token.authorize_url(options[:authorize_params])
        else
          redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url))
        end

      rescue ::Timeout::Error => e
        fail!(:timeout, e)
      rescue ::Net::HTTPFatalError, ::OpenSSL::SSL::SSLError => e
        fail!(:service_unavailable, e)
      end


      def consumer
        p "in consumer"

        consumer = GarminConsumer.new(options.consumer_key, options.consumer_secret, options.client_options)
        consumer.http.open_timeout = options.open_timeout if options.open_timeout
        consumer.http.read_timeout = options.read_timeout if options.read_timeout
        consumer
      end

      class GarminConsumer < ::OAuth::Consumer
        protected

        def create_http_request(*params)
          req = super
          if ENV['GARMIN_USERNAME']
            req.basic_auth ENV['GARMIN_USERNAME'], ENV['GARMIN_PASSWORD']
          end
          req
        end
      end
    end
  end
end
