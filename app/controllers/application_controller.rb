class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception

  FIREBASE_API_KEY = 'AIzaSyCuudYE6B0FpHibnTYGZbMc9wrNia2mOvs'

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last

    unless token
      render json: { error: 'Authorization header is missing' }, status: :unauthorized
      return
    end

    begin
      decoded_token = decode_id_token(token)
      @current_user = fetch_user(decoded_token['sub'])
    rescue RestClient::ExceptionWithResponse => e
      render json: { error: 'Failed to verify ID token' }, status: :unauthorized
    rescue => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  private

  def decode_id_token(token)
    response = RestClient.get "https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=#{token}"
    JSON.parse(response.body)
  end

  def fetch_user(uid)
    response = RestClient.get "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=#{FIREBASE_API_KEY}",
                               params: { localId: uid }
    user_info = JSON.parse(response.body)['users'].first
    create_or_update_user(user_info)
  end

  def create_or_update_user(user_info)
    # Assuming 'email' is the unique identifier in your database
    user = User.find_by(email: user_info['email'])
    display_name = user_info['displayName'] || ''
    names = display_name.split(' ', 2) # Split into maximum two parts
    first_name = names[0]
    last_name = names[1] || ''

    if user
      user.update!(
        first_name: first_name,
        last_name: last_name
      )
    else
      user = User.create!(
        email: user_info['email'],
        first_name: first_name,
        last_name: last_name
      )
    end
    user
  end
end
