class BuyAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'ハイフンを含む郵便番号を入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: '都道府県を選択してください' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '10桁か11桁の数字を入力してください' }
  end

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    ShoppingAddress.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city,
      address: address, building: building, phone_number: phone_number, buy_id: buy.id
    )
  end
end
