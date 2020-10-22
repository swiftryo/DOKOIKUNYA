class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships
  #フォロー中間テーブルを設定し、フォローしているuserたちを取得
  has_many :followings, through: :relationships, source: :follow
  #上記の逆、入り口をfollow_idとする
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  #user_idを入り口
  has_many :followers, through: :reverse_of_relationships, source: :user

  enum prefecture_code: {
    "---":0,
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }

  validates :name, presence: true, length: { in: 1..75 }
  validates :email, presence: true

  def active_for_authentication?
    super && (self.is_deleted == false)
  end


  def User.search(search, user_or_product)
    if user_or_product == "1"
       User.where(['name LIKE ?', "%#{search}%"])
    else
       User.all
    end
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
