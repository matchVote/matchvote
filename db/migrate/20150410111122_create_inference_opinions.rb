class CreateInferenceOpinions < ActiveRecord::Migration
  def change
    create_table :inference_opinions do |t|
      t.boolean :agrees
      t.references :stance, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
