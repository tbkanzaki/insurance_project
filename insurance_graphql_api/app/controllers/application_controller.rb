class ApplicationController < ActionController::API

  def decode_token
    begin
      token = request.headers['Authorization'].split(' ').last
      hmac_secret = ENV['HMAC_SECRET_KEY']
      JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
      rescue StandardError => e
        raise "Authorization denied: #{e}"
     end
  end

  def encode_token(decoded_token) #email, alg
    email = (decoded_token[0]["email"]
    alg = decoded_token[1]["alg"])
    hmac_secret = ENV['HMAC_SECRET_KEY']
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { email: email, exp: exp }
    JWT.encode(exp_payload, hmac_secret, alg)
  end

end
