require 'singleton'

class SimpleExample
  include Singleton


  def create_message payload
    account = Model::Account.where(name: payload["account"]).first
    channel = account.channels.where(name: payload["channel"]).first
    dest = payload["dest"]
    message_payload = payload["payload"]

    account.messages.create!(dest: dest, channel: channel.name, payload: message_payload)
  end

end
