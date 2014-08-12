class CheckinResponder < ActionController::Responder
  def to_json
    total_checkins = {}
    if options.has_key?(:total_checkins) 
      total_checkins = {total_checkins: options[:total_checkins]}
    end

    status = has_errors? ? :unprocessable_entity : :ok
    render json: {status: status}.merge(total_checkins)
  end
end
