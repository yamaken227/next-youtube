require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '登録成功時' do
      it 'channel_nameとemail、password、password_confirmation、subscribers_num、channel_url
      what_channelが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'subscribers_numが半角数字なら' do
        @user.subscribers_num = 9999
        expect(@user).to be_valid
      end
      it 'subscribers_numが9999以下なら' do
        @user.subscribers_num = 9999
        expect(@user).to be_valid
      end
      it '重複したemailがなければ登録できる' do
        @user.email = 'aaa@test'
        another_user = FactoryBot.build(:user)
        another_user.email = 'aaa@hoge'
        expect(another_user).to be_valid
      end
      it 'emailに@があれば登録できる' do
        @user.email = 'aaa@test'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上なら登録できる' do
        @user.password = 'aaa123aaa'
        @user.password_confirmation = 'aaa123aaa'
        expect(@user).to be_valid
      end
      it 'passwordが半角英数混合なら登録できる' do
        @user.password = 'aaa123aaa'
        @user.password_confirmation = 'aaa123aaa'
        expect(@user).to be_valid
      end
      it 'channel_urlは「https://www.youtube.com/channel/」が含まれているなら登録できる' do
        @user.channel_url = 'https://www.youtube.com/channel/'
        expect(@user).to be_valid
      end
      it 'twitter_urlが空でない場合「https://twitter.com/」が含まれているなら登録できる' do
        @user.twitter_url = 'https://twitter.com/'
        expect(@user).to be_valid
      end
    end
    context '登録失敗時' do
      it 'channel_nameが空だと登録できない' do
        @user.channel_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル名を入力してください')
      end
      it 'subscribers_numが空だと登録できない' do
        @user.subscribers_num = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル登録者数を入力してください')
      end
      it 'subscribers_numが10,000以上だと登録できない' do
        @user.subscribers_num = 10_000
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル登録者数が10000人以上の方はご利用いただけません')
      end
      it 'subscribers_numが半角数字以外の場合（半角英語では）登録できない' do
        @user.subscribers_num = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル登録者数は半角数字のみ入力可能です')
      end
      it 'subscribers_numが半角数字以外の場合（全角）登録できない' do
        @user.subscribers_num = '１０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル登録者数は半角数字のみ入力可能です')
      end
      it 'subscribers_numが半角英数混合の文字の場合登録できない' do
        @user.subscribers_num = '111a'
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネル登録者数は半角数字のみ入力可能です')
      end
      it 'channel_urlが空だと登録できない' do
        @user.channel_url = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネルURLを入力してください')
      end
      it 'channel_urlに「https://www.youtube.com/channel/」が含まれていないなら登録できない' do
        @user.channel_url = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('チャンネルURLはYouTubeのチャンネルURLのみご利用いただけます')
      end
      it 'twitter_urlが空でない時「https://twitter.com/」が含まれていないなら登録できない' do
        @user.twitter_url = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Twitter urlはTwitterのURLのみご利用いただけます')
      end
      it 'what_channelが空だと登録できない' do
        @user.what_channel = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('どんなチャンネル?欄を入力してください')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに『@』がないと登録できない' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordは5文字以下では登録できない' do
        @user.password = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'password:半角英数混合(半角英語のみ)' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end
      it 'password:半角英数混合(半角数字のみ)' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end
      it 'password:全角文字は登録できない' do
        @user.password = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めてください')
      end
      it 'passwordは確認用含めて2回入力しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password_confirmation = 'abc123abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
