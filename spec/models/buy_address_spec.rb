require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @buy_address = FactoryBot.build(:buy_address, user_id: @user.id, item_id: @item.id)
    sleep (1)
  end

  describe '購入できるとき' do
    context '購入できるとき' do
      it 'すべてのフォームの入力がされている' do
        expect(@buy_address).to be_valid
      end
      it "tokenがあれば保存ができること" do
        expect(@buy_address).to be_valid
      end
      it "建物名が空の場合でも保存できること" do
        @buy_address.building_name = ''
        @buy_address.valid?
        expect(@buy_address).to be_valid
      end
    end

    context '商品を購入できないとき' do
      it 'postal_code が空では登録できないこと' do
        @buy_address.postal_code = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_code が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buy_address.postal_code = '123ー4567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code は(−)を入れて7文字で入力してください")
      end
      it 'area_idが 1 では保存できないこと' do
        @buy_address.area_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Area は−−以外を選択してください")
      end
      it 'municipalities が空では保存できないこと' do
        @buy_address.municipalities = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'address が空では保存できないこと' do
        @buy_address.address = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_number が空では保存できないこと' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_number が英数混合では保存できないこと' do
        @buy_address.phone_number = '００００００００aaa'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number は半角数字で入力してください")
      end
      it 'phone_number が11桁以内の数値のみでなければ保存できないこと' do
        @buy_address.phone_number = '０００００００００００'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number は半角数字で入力してください")
      end
      it "token が空では登録できないこと" do
        @buy_address.token = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end
      it "user_id が空では登録できないこと" do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end
      it "item_id が空では登録できないこと" do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end