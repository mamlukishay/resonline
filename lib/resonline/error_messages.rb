module Resonline
  module ErrorMessages
    def self.failed_response(response)
      { error: 'error' }
    end

    def self.exception(e)
      { error: e.message }
    end
  end
end