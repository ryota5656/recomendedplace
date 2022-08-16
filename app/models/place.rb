class Place < ApplicationRecord
  # 記事/お気に入り → 1:多
  belongs_to :user
  has_many   :favorites, dependent: :destroy
  has_many   :favorite_users, through: :favorites, source: :user
  has_many   :completes, dependent: :destroy
  has_many   :complete_users, through: :completes, source: :user
end
