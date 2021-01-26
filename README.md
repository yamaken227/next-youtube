# Next YouTube
このサービスを使うことで動画を投稿する人は多くの人に観られる機会を獲得し、
視聴する人は、観たことのないYouTuberや動画に出会う機会を獲得できます。

## Description
本サービスのターゲットは二種類で、
一つはYouTubeチャンネル登録者10000人未満のYouTuber
もう一つは、見るチャンネルが固定化されていて新しいチャンネルを開拓したいと考える視聴者です。
特に後者のターゲットを意識しながら作ったサービスになります。
本サービスは娯楽サービスなので、「楽」に使っていただくことを意識して作成いたしましたので、
単機能且つ直感的に何をすればいいのががわかる設計になっております。
「楽」に自分好みの動画を見つけ、また見つけられることができるサービスがNext YouTubeです。

## Demo
![demo](https://user-images.githubusercontent.com/74579887/105815770-c5335000-5ff6-11eb-960a-dbcfab781826.gif)

## App URL
### https://next-youtube.herokuapp.com/

## Usage
### 基本的にログインなしで使うことができますが、投稿機能などのテストは以下のテストアカウントからログインを行うことでできます
テストアカウント
 - メールアドレス:test@hoge
 - パスワード:hogehoge123
test_channelという名前でログインされます。
こちらがテストアカウントになります。

## Commitment
本サービスのこだわりは「楽さ」にあります。
本サービスはYouTube視聴者を対象にしております。
そのため、本サービスはYouTubeより面倒で堅苦しいサービスであってはならない、またYouTubeではできないことをしなければならないと考えています。
なのでトップページでは全動画のシャッフルや、検索ワードでシャッフルをし、そのページ内で動画も視聴可能です。
それが本サービスの「楽さ」たる所以です。
またメッセージ機能においてもログインせずにメッセージを送ることのできる匿名メッセージ機能を実装しております。
YouTubeではログインをしないとコメントを打つことができません。ですが、名前を出さず気楽に自分の思ったことを投稿者に伝えたいというニーズは必ずあります。そういった視聴者の課題を解決するために匿名メッセージ機能を実装しました。
また、匿名メッセージ機能にはもう一つ意味が込められています。
匿名メーッセージを送ると、動画の投稿者以外をのメッセージを見ることはできません。なぜなら、他者のメッセージによる余計な先入観を防ぐためです。
YouTubeではコメント機能がついており、そこでは優良なコメントもある一方で、ネタバレや誹謗中傷と捉えることのできるコメントもしばしばあります。初めて見る人がそのコメントを見てしまうと見るのをやめてしまうかもしれません。
そんな可能性を排除し、自分自身が面白いと思う動画やYouTuberを発見し、どんどんYouTuberを開拓していってほしいという願いを込めて作りました。


# テーブル設計

## users テーブル

| Column          | Type    | Options                        |
| --------------- | --------| -------------------------------|
| email           | string  | null: false                    |
| password        | string  | null: false                    |
| channel_name    | string  | null: false                    |
| subscribers_num | integer | null: false                    |
| channel_url     | string  | null: false                    |
| what_channel    | text    | null: false                    |
| twitter_url     | string  | null: false                    |

### Association

- has_many :posts
- has_many :comments

## posts テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| title      | string     | null: false                    |
| highlights | text       | null: false                    |
| video_url  | string     | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association

- belongs_to  :user
- has_many    :comments

## comments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| post       | references | null: false, foreign_key: true |

### Association
- belongs_to :post