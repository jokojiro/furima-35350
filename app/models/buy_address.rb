class BuyAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,:address, :postal_code, :area_id, :municipalities, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code,        format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は(−)を入れて7文字で入力してください' }
    validates :area_id,   numericality: { other_than: 1, message: "は−−以外を選択してください" }
    validates :municipalities
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :token
  end
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は(−)を抜いた11桁までを入力してください' }

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, address: address, municipalities: municipalities,  building_name: building_name, phone_number: phone_number,
                   buy_id: buy.id)
  end
end