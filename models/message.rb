module Model
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in database: ->{ Thread.current[:db_name] }

    field :dest,      type: String
    field :channel,   type: String
    field :payload,   type: BSON::Binary

    def payload=(payload)
      self.write_attribute(:payload, BSON::Binary.new(payload))
    end

  end
end
