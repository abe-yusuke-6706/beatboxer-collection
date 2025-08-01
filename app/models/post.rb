class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :tag_relations, dependent: :destroy
    has_many :tags, through: :tag_relations

    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65535 }

    def bookmark_by?(user)
        bookmarks.where(user_id: user).exists?
    end

    def save_tags(tags)
        tags.each do |tag|
            self.tags.find_or_create_by(name: tag)
        end
    end

    def self.ransackable_attributes(auth_object = nil)
        [ "beatboxer_id", "body", "created_at", "id", "likes_count", "title", "updated_at", "user_id", "youtube_video" ]
    end

    def self.ransackable_associations(auth_object = nil)
        [ "bookmarks", "comments", "likes", "tag_relations", "tags", "user" ]
    end
end
