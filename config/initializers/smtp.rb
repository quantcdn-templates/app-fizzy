# SMTP configuration from environment variables

if ENV["SMTP_ADDRESS"].present?
  Rails.application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV["SMTP_ADDRESS"],
      port: ENV.fetch("SMTP_PORT", 587).to_i,
      domain: ENV.fetch("SMTP_DOMAIN", ENV["APP_HOST"]&.split(":")&.first || "localhost"),
      user_name: ENV["SMTP_USER_NAME"].presence,
      password: ENV["SMTP_PASSWORD"].presence,
      authentication: ENV["SMTP_USER_NAME"].present? ? ENV.fetch("SMTP_AUTHENTICATION", "plain").to_sym : nil,
      enable_starttls_auto: ENV.fetch("SMTP_ENABLE_STARTTLS_AUTO", "true") == "true",
      open_timeout: 5,
      read_timeout: 5
    }.compact

    config.action_mailer.raise_delivery_errors = ENV.fetch("SMTP_RAISE_ERRORS", "false") == "true"
    config.action_mailer.perform_deliveries = true
  end
end
