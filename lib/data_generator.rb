require 'singleton'

class DataGenerator
  include Singleton

  attr_reader :possible_payloads

  TOTAL_ACCOUNT = 10
  TOTAL_CHANNELS = 10

  def initialize
    @possible_payloads = {accounts: [], channels: {}}
  end


  def generate
    @possible_payloads = {accounts: [], channels: {}}
    generate_accounts
    generate_channels
  end

  def drop
    Model::Account.all.each do |account|
      account.channels.destroy_all
      account.messages.destroy_all
      account.destroy
    end
  end

  def random_payload
    account_name = @possible_payloads[:accounts].sample
    channel_name = @possible_payloads[:channels][account_name].sample
    {"payload" => Faker::Lorem.paragraph, "dest" => Faker::StarWars.vehicle, "channel" => channel_name, "account" => account_name}
  end

  private

    def generate_accounts
      TOTAL_ACCOUNT.times do
        name = Faker::GameOfThrones.house
        Model::Account.create!(name: name)
        @possible_payloads[:accounts] << name
      end
    end


    def generate_channels
      Model::Account.all.each do |account|
        @possible_payloads[:channels][account.name] = []
        TOTAL_CHANNELS.times do
          name = Faker::Pokemon.name
          account.channels.create!(name: name)
          @possible_payloads[:channels][account.name] << name
        end
      end
    end

end

