class Tag < ApplicationRecord
    validates :name, length: { maximum: 40 }

    has_many :tag_relations, dependent: :destroy
    has_many :posts, through: :tag_relations
end
