module Model
  class Channel
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in database: ->{ Thread.current[:db_name] }
    field :name,  type: String

  end
end
