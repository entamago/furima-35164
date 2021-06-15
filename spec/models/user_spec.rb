require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birth_dateが存在すれば登録できる' do
        @user.nickname = 'ニックネーム'
        @user.email = 'test@test.com'
        @user.password = 'test56'
        @user.password_confirmation = 'test56'
        @user.last_name = '任意の名前'
        @user.first_name = 'フリマ太郎'
        @user.last_name_kana = 'ニンイノナマエ'
        @user.first_name_kana = 'フリマタロウ'
        @user.birth_date = '1980-11-22'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'ott456'
        @user.password_confirmation = 'ott456'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailには＠が含まれないと登録できない' do
        @user.email = 'testattest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ot345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'ユーザー本名は、名前が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名は、名字が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名の名前は、全角での入力でなければ登録できない' do
        @user.first_name = 'testname'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角の文字を入力してください')
      end
      it 'ユーザー本名の名字は、全角での入力でなければ登録できない' do
        @user.last_name = 'ﾃｽﾄﾈｰﾑ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角の文字を入力してください')
      end
      it 'ユーザー本名のフリガナは、名前が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、名字が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名の名前のフリガナは、全角カタカナでの入力でなければ登録できない' do
        @user.first_name_kana = 'ふりがな'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end
      it 'ユーザー本名の名字のフリガナは、全角カタカナでの入力でなければ登録できない' do
        @user.last_name_kana = 'ﾌﾘｶﾞﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end
      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
