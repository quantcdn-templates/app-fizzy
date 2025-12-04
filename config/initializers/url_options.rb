# URL options for containerized deployment
# Overrides Fizzy's hardcoded fizzy.localhost:3006

Rails.application.configure do
  if ENV["APP_HOST"].present?
    host, port = ENV["APP_HOST"].split(":")
    protocol = ENV.fetch("RAILS_FORCE_SSL", "false") == "true" ? "https" : "http"

    url_options = { host: host, protocol: protocol }
    url_options[:port] = port.to_i if port && ![80, 443].include?(port.to_i)

    # Override both controller and mailer URL options
    config.action_controller.default_url_options = url_options
    config.action_mailer.default_url_options = url_options

    # Allow configured host
    config.hosts.clear
    config.hosts << host
    config.hosts << /.*\.#{Regexp.escape(host)}/
    config.hosts << "localhost"
    config.hosts << /\Alocalhost:\d+\z/

    # Fizzy redirects between paths - allow this
    config.action_controller.raise_on_open_redirects = false
  end
end
