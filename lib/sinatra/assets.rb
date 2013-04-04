#starting point = https://mutelight.org/asset-pipeline

require 'sprockets'

class Assets < Sinatra::Base
  configure do
    set :assets, (Sprockets::Environment.new { |env|
      root = File.expand_path('../../../', __FILE__) #custom, not sinatra's root
      env.append_path(root + "/app/assets/images")
      env.append_path(root + "/app/assets/javascripts")
      env.append_path(root + "/app/assets/stylesheets")

      # compress everything in production
      if ENV["RACK_ENV"] == "production"
        env.js_compressor  = YUI::JavaScriptCompressor.new
        env.css_compressor = YUI::CssCompressor.new
      end
    })
  end

  get "/assets/application.js" do
    content_type("application/javascript")
    settings.assets["application.js"]
  end

  get "/assets/application.css" do
    content_type("text/css")
    settings.assets["application.css"]
  end

  %w{jpg png}.each do |format|
    get "/assets/:image.#{format}" do |image|
      content_type("image/#{format}")
      settings.assets["#{image}.#{format}"]
    end
  end
end
