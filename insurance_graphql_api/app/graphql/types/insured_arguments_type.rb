module Types
  class InsuredArgumentsType < Types::BaseInputObject
    description "Arguments for creating a car insurance policy: Insured person data"
    argument :cpf, String, required: true
    argument :name, String, required: true
  end
end
