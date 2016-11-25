module Model
  class Model::Account
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name,  type: String

    def db_name
      @db_name ||= "mongoid_performance_db_#{name}"
    end

    def channels
      constant = "Mongoid::Tenants::#{name.camelcase}::Model::Channel"
      if !constant.safe_constantize
        update_mongoid_config
        Mongoid.create_tenant(Model::Channel, name, db_name)
      end
      Thread.current[:db_name] = db_name
      constant.constantize
    end

    def messages
      constant = "Mongoid::Tenants::#{name.camelcase}::Model::Message"
      if !constant.safe_constantize
        update_mongoid_config
        Mongoid.create_tenant(Model::Message, name, db_name)
      end
      Thread.current[:db_name] = db_name
      constant.constantize
    end

    private
      def update_mongoid_config
        if name
          session_hash = {
            "database" => "#{db_name}",
            "hosts" => ["localhost:37017"]
          }
          # Add the new database configuration to the mongoid clients list
          Mongoid.clients[db_name.to_sym] = session_hash
        end
      end
  end
end
