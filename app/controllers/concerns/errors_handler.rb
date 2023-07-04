# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  class BadRequest < StandardError
  end

  class Forbidden < StandardError
  end

  class Unauthorized < StandardError
  end

  included do
    rescue_from BadRequest, with: :handle_bad_request
    rescue_from Unauthorized, with: :handle_unauthorized
    rescue_from Forbidden, with: :handle_forbidden
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  end

  private

  def handle_bad_request(exception)
    # render json: json_with_error(message: exception.message), status: :bad_request
  end

  def handle_unauthorized
    flash[:error] = I18n.t('session.login.required')
    redirect_to root_path
  end

  def handle_record_invalid(exception)
    flash[:error] = exception.record&.errors&.messages
    redirect_to root_path
  end
end
