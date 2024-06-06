class CreatePolicies < ActiveRecord::Migration[7.1]
  def change
    create_table :policies do |t|
      t.integer :policy_id, null: false
      t.date :issue_date
      t.date :end_coverage_date
      t.references :vehicle, null: false, foreign_key: true
      t.references :insured, null: false, foreign_key: true

      t.timestamps
    end
    add_index :policies, :policy_id, unique: true
  end
end
