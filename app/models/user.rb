class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/ }
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角の文字を入力してください' } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' } do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :birth_date
  end

  has_many :items
  has_many :buys
end
