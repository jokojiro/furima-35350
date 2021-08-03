class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_one :buy
  
  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_id
    validates :area_id
    validates :delivery_days_id
    validates :price
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :area
  belongs_to :delivery_days

  with_options numericality: { other_than: 1 } do
    validates :shipping_id
    validates :area_id
    validates :delivery_days_id
    validates :category_id
    validates :condition_id
  end
  validates_inclusion_of :price, in: 300..9999999
  validates :price, numericality: { with: /\A[0-9]+\z/}
end
