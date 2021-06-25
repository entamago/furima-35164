class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :price
    validates :info
    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :sales_status_id
      validates :fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
  end

  has_one_attached :image
  validate :image_presence

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :fee_status
  belongs_to :sales_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  private
  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを選択してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end