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
      it 'video_urlが「https://www.youtube.com/watch?v=」の形でなおかつ
          イコールの後ろに「任意の半角英数大文字小文字と記号」を11文字含む文字列なら投稿できる' do
        @post.video_url = 'https://www.youtube.com/watch?v=cCmT1fi7Jlw'
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
      it 'video_urlが「https://www.youtube.com/watch?v=」を含む形でないなら登録できない' do
        @post.video_url = 'aaaa'
        @post.valid?
        expect(@post.errors.full_messages).to include('動画のURLはYouTubeの動画のURLのみご利用いただけます')
      end
      it 'video_urlが「https://www.youtube.com/watch?v=」以降が「任意の半角英数大文字小文字と記号」
          を11文字含む文字列でないなら登録できない' do
        @post.video_url = 'https://www.youtube.com/watch?v='
        @post.valid?
        expect(@post.errors.full_messages).to include('動画のURLはYouTubeの動画のURLのみご利用いただけます')
      end
    end
  end
end
