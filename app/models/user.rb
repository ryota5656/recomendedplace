class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :current_password

  #ユーザー/お気に入り → 1:多
  has_many :favorites, dependent: :destroy
  has_many :favorites_places, through: :favorites, source: :place

  #登録メソッド
  def addfav(place)
    favorites.find_or_create_by(place_id: place.id)
  end

  #登録解除メソッド
  def removefav(place)
    favorite = favorites.find_by(place_id: place.id)
    favorite.destroy if favorite
  end

  #確認メソッド
  def checkfav?(place)
    self.favorites_places.include?(place)
  end

  #ユーザー/完了 → 1:多
  has_many :completes, dependent: :destroy
  has_many :completes_places, through: :completes, source: :place

  #完了メソッド
  def addcomp(place)
    completes.find_or_create_by(place_id: place.id)
  end

  #確認メソッド
  def checkcomp(place)
    self.completes_places.include?(place)
  end
  mount_uploader :image, ImageUploader

end