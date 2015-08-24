module Larch
  module Serializer
    extend ActiveSupport::Concern

    included do
      attributes :position, :ancestry, :ancestry_depth
      has_one :parent, embed: :ids
    end
  end
end



