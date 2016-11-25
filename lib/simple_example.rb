require 'singleton'

class SimpleExample
  include Singleton


  def create_message payload
    account = Model::Account.find_by(name: payload["account"])
    channel = account.channels.find_by(name: payload["channel"])
    dest = payload["dest"]
    message_payload = payload["payload"]

    account.messages.create!(dest: dest, channel: channel.name, payload: message_payload)
  end

end
