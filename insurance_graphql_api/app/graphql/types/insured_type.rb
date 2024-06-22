module Types
  class InsuredType < Types::BaseObject
    description "Insured person"
    field :cpf, String, null: false
    field :name, String, null: false
  end
end
