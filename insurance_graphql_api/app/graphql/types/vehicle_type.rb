module Types
  class VihicleType < Types::BaseObject
    description "Insured vehicle"
    field :id, ID, null: false
    field :plate, String, null: false
    field :brand, String, null: false
    field :model, String, null: false
    field :year, String, null: false
  end
end
