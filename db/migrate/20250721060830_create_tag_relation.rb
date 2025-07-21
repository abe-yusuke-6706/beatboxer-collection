class CreateTagRelation < ActiveRecord::Migration[7.2]
  def change
    create_table :tag_relations do |t|
      t.references :post, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
      t.timestamps
    end
  end
end
