class Larch::MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :depth, :position, :fixed,
             :updated_at, :created_at, :linked_content, :content_type

  has_one :parent, embed: :ids
#  has_many :children, embed: :ids

  def content_type
    object.content_type.try(:underscore)
  end

  def linked_content
    { id: object.content_id, type: object.content_type } if object.content
  end

end
