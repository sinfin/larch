module Larch
  module Model
    extend ActiveSupport::Concern
    
    included do
      has_ancestry orphan_strategy: :destroy, cache_depth: true      
      acts_as_list scope: [:ancestry]
    end

    module ClassMethods
      def create_tree(*languages,&block)
        TreeBuilder.new(self).instance_eval(&block)
      end

      def special(name)
        find_by_system_name!(name)
      end
    end
  end
end

