module Rack
  class AccessRemoteAssets
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      if Rails.env.development? && env["PATH_INFO"].include?("/system/images") && file_missing?(env)
        begin
          original_uri = env["REQUEST_URI"]
          return [
            307,
            {
              'Location' => [
                "#{@options.fetch(:uri)}/system",
                original_uri.split("/system")[1]
              ].join,
              'Content-Type' => Rack::Mime.mime_type(::File.extname(env["REQUEST_PATH"].split("/").last))
            },
            ["Redirecting"]
          ]
        rescue KeyError
          print <<-URI.strip_heredoc
          No target uri set. Please make sure to provide an uri in your application.rb, like this
          ```
          require "access_remote_assets"
          config.middleware.insert_after(
            Rack::ETag,
            AccessRemoteAssets
            uri: "https://username:password@example.com" # Use basic auth if necessary.
          )
          ```
          URI
        end
      end
      @app.call(env)
    end

    private

    def file_missing?(env)
      !File.exist?(File.join(Rails.root, "public", env["REQUEST_PATH"]))
    end
  end
end