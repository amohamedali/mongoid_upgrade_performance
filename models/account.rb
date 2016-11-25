module Model
  class Model::Account
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name,  type: String

    def db_name
      @db_name ||= "mongoid_performance_db_#{name}"
    end

    def channels
      load_tenant_model Model::Channel
    end

    def messages
      load_tenant_model Model::Message
    end

    private
      def load_tenant_model model_klass
        constant = "Mongoid::Tenants::#{name.camelcase}::#{model_klass}"
        if !constant.safe_constantize
          update_mongoid_config
          Mongoid.create_tenant(model_klass, name, db_name)
        end
        Thread.current[:db_name] = db_name
        constant.constantize
      end

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
