require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'Tvs6geNkx8JAl8Qw4g6Syw', 'aKgNBH2hF8mtNcpWSoUJWtKWyOfDE8TaUzmsYxZSNQ'  
  provider :facebook, '154065854679319', '45dcc6c9a1cf86fd9856f50b734f3cee',:client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" } }
	provider :linked_in, 'zt5z1qmyhgdv', '4hwubEq3ST4OZsCo'  
   provider :open_id, OpenID::Store::Filesystem.new('/tmp')
   provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
end