module Type
  class InsuredType < Types::BaseObject
    description "Insured person"
    field :id, ID, null: false
    field :cpf, String, null: false
    field :name, String, null: flase
  end
end
