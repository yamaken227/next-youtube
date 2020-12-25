require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '動画投稿' do
    context '投稿成功時' do
      it 'title、highlights、video_urlが存在すれば投稿できる' do
        expect(@post).to be_valid
      end
    end
    context '投稿失敗時' do
      it 'titleが空なら投稿できない' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include('動画のタイトルを入力してください')
      end
      it 'hightlightsが空なら投稿できない' do
        @post.highlights = ''
        @post.valid?
        expect(@post.errors.full_messages).to include('動画の見どころを入力してください')
      end
      it 'video_urlが空なら投稿できない' do
        @post.video_url = ''
        @post.valid?
        expect(@post.errors.full_messages).to include('動画のURLを入力してください')
      end
    end
  end
end
