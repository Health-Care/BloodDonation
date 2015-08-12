

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1638457706426157'], ENV['608de22bb1900e8ba6f52142253f0533']
end

