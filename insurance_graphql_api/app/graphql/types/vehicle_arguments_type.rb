module Types
  class VehicleArgumentsType < Types::BaseInputObject
    description "Arguments for creating a car insurance policy: Insured vehicle data"
    argument :plate, String, required: true
    argument :brand, String, required: true
    argument :model, String, required: true
    argument :year, String, required: true
  end
end
