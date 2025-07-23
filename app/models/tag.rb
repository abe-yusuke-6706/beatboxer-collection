class Tag < ApplicationRecord
    has_many :tags_relations, dependent: :destroy
    validates :name, length: { maximum: 40 }
end
