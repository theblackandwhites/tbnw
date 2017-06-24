require 'gibbon'

gibbon = Gibbon::Request.new(api_key: ENV["mailchimp_api_key"])
gibbon.timeout = 30
gibbon.open_timeout = 30
