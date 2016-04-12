class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :email, :first_name, :last_name
end
