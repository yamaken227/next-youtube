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