class ApplicationController < ActionController::API
  def authenticate_token
    begin
      token = request.headers['Authorization'].split(' ').last
      hmac_secret = ENV['HMAC_SECRET_KEY']
      JWT.decode(token, hmac_secret, true, algorithm: 'HS256')
      rescue StandardError => e
        return render json: { errors: [{ message: "Authorization denied: #{e}" }], data: {} }, status: :unauthorized
    end
  end
end
