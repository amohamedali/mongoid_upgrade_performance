# ensure we are loaded
Model::Account

module Mongoid
  Tenants = Module.new

  module Collections
    included do
      class_attribute :_collection, :collection_name
      self.collection_name = self.name.collectionize
    end
  end

  def create_tenant(klass, name, db_name = nil)
    db_name ||= name
    namespaced_klass_name = klass_name = klass.name
    tenant_klass_name = name.camelcase

    if !Mongoid::Tenants.const_defined?(tenant_klass_name, false)
      Mongoid::Tenants.const_set(tenant_klass_name, Module.new)
    end
    sub_module = Mongoid::Tenants.const_get(tenant_klass_name, false)

    if (levels = klass_name.split('::')).size > 1
      klass_name = levels.pop
      levels.each do |l|
        if !sub_module.const_defined?(l, false)
          sub_module = sub_module.const_set(l, Module.new)
        else
          sub_module = sub_module.const_get(l, false)
        end
      end
    end

    if !sub_module.const_defined?(klass_name, false)
      sub_module.const_set(klass_name, kls = Class.new(klass))
      kls.class_eval <<-RUBY, __FILE__, __LINE__ + 1
        set_database :#{db_name}

        def self.hereditary?
          ::#{namespaced_klass_name}.hereditary?
        end

        def self.tenant
          "#{name}"
        end

        def tenant
          self.class.tenant
        end

      RUBY
      kls.after_tenant if kls.respond_to?(:after_tenant)
    end
  end

end
