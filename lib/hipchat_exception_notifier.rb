require "hipchat_exception_notifier/version"
require "hipchat"

class HipchatExceptionNotifier
  def self.default_ignore_exceptions
    [].tap do |exceptions|
      exceptions << ::ActiveRecord::RecordNotFound if defined? ::ActiveRecord::RecordNotFound
      exceptions << ::AbstractController::ActionNotFound if defined? ::AbstractController::ActionNotFound
      exceptions << ::ActionController::RoutingError if defined? ::ActionController::RoutingError
    end
  end

  def initialize(app, options = {})
    @app, @options = app, options
    @options[:ignore_exceptions] ||= self.class.default_ignore_exceptions
  end

  def call(env)
    @app.call(env)
  rescue Exception => ex
    unless Array.wrap(@options[:ignore_exceptions]).include?(ex.class)
      deliver_exception(ex)
    end

    raise ex
  end

  private

  def deliver_exception(ex)
    client = HipChat::Client.new(hipchat_token)
    client[hipchat_room_name].
      send(hipchat_user, "Error: #{ex.message}", notify: hipchat_announce)
  end

  def hipchat_token
    @options.fetch(:token)
  end

  def hipchat_room_name
    @options.fetch(:room_name)
  end

  def hipchat_user
    @options.fetch(:user)
  end

  def hipchat_announce
    @options.fetch(:announce) { false }
  end
end
