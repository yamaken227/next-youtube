require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe 'メッセージ投稿' do
    context 'メッセージ投稿成功時' do
      it 'messageが存在すれば投稿できる' do
        expect(@message).to be_valid
      end
    end
    context 'メッセージ投稿失敗時' do
      it 'messageが空なら登録できない' do
        @message.message = ''
        @message.valid?
        expect(@message.errors.full_messages).to include('Messageを入力してください')
      end    
    end
  end
end
