class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/ }
    validates :nickname
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角の文字を入力してください' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角の文字を入力してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' }
    validates :birth_date
  end
end
