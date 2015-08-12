

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1638457706426157', '608de22bb1900e8ba6f52142253f0533'
end

