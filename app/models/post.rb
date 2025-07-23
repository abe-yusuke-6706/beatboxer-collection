class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :tags_relations, dependent: :destroy

    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65535 }

    def bookmark_by?(user)
        bookmarks.where(user_id: user).exists?
    end
end
