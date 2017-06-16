require 'gibbon'

gibbon = Gibbon::Request.new(api_key: "0a9ffb6db9a6a723e4f0841f18dc3636-us15")
gibbon.timeout = 30
gibbon.open_timeout = 30
