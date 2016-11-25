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
        constant.constantize

      end

      def update_mongoid_config
        if name
          dbconf = {'database' => "mongoid_performance_db_#{db_name}", 'host' => 'localhost', 'port' => 27017}
          mconfig = Mongoid::Config.databases
          mconfig[db_name], mconfig["#{db_name}_slaves"] = Mongoid.config.send(:configure_databases, dbconf)
        end
      end
  end
end
