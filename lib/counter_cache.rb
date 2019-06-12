require "counter_cache/version"

module CounterCache

  class Error < StandardError; end

  module ClassMethods

    # counter_cache :items
    # counter_cache :items, scope: { status: :approved }
    # counter_cache :items, column: :items_count
    # counter_cache :items, scope: { status: :approved }, column: :approved_items_count
    def counter_cache(relationship, options = {})
      raise ArgumentError, "counter_cache: Hash expected, got #{options.class.name} from options" if not options.is_a?(Hash)

      association = self.reflect_on_all_associations(:belongs_to).find { |ast| ast.name == relationship }
      raise ArgumentError, "counter_cache: #{relationship} is not defined in #{self.model_name.to_s}" if association.nil?

      if options[:scope].is_a?(Symbol) && self.methods.exclude?(options[:scope].to_sym)
        raise ArgumentError, "counter_cache: #{options[:scope]} is not a scope of #{self.model_name.to_s}"
      end

      column_name = options[:column] || "#{self.table_name}_count".to_sym
      callback_method_name = "callback_to_cache_for_#{column_name}!".to_sym

      self.after_commit callback_method_name

      self.instance_eval do

        define_method callback_method_name do
          association_object = self.public_send(association.name)
          if association_object && association_object.class.column_names.include?(column_name.to_s)
            relation = self.class.unscoped.where(association.name => association_object)
            case options[:scope]
            when Hash, String
              relation = relation.where(options[:scope])
            when Symbol
              relation = relation.public_send(options[:scope].to_sym)
            end
            association_object.update(column_name => relation.size)
          end
        end

        private callback_method_name

      end
    end

  end

end

ActiveRecord::Base.send :extend, CounterCache::ClassMethods
