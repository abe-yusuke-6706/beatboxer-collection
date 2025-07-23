class Tag < ApplicationRecord
    has_many :tags_relations, dependent: :destroy
end
