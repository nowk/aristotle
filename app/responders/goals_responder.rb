class GoalsResponder < ActionController::Responder
  def to_json
    if !has_errors?
      # TODO why does this render show for a json response?
      format.json { render :show, status: :created, location: resource }
    else
      super
    end
  end
end
