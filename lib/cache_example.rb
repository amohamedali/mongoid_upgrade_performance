require 'singleton'

class CacheExample
  include Singleton

  def initialize
    @accounts = {}
    @channels = {}

  end

  def create_message payload
    account = @accounts[payload["account"]]
    channel = @channels[payload["account"]][payload["channel"]]
    dest = payload["dest"]
    message_payload = payload["payload"]
    account.messages.create!(dest: dest, channel: channel.name, payload: message_payload)
  end

  def generate_cache
    Model::Account.all.map do |account|
      @accounts[account.name] = account
      account.channels.each do | channel |
        @channels[account.name] ||= {}
        @channels[account.name][channel.name] = channel
      end
    end
  end

end
