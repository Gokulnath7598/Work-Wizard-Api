require 'googleauth'
require 'rest-client'

scope = 'https://www.googleapis.com/auth/cloud-platform'

authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(Rails.root.join('config/secrets/serviceAccountKey.json')),
  scope: scope
)

authorizer.fetch_access_token!
GOOGLE_AUTHORIZER = authorizer