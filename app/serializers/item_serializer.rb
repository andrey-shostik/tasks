class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :completed_at
end
