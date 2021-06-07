# README

# テーブル設計

## users テーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| email           | string     | null: false       |
| password        | string     | null: false       |
| nickname        | string     | null: false       |
| first_name      | string     | null: false       |
| last_name       | string     | null: false       |
| first_name_kana | string     | null: false       |
| last_name_kana  | string     | null: false       |
| birth_date      | date       | null: false       |

### Association

- has_many :items
- has_many :shopping_addresses

## items テーブル

| Column                | Type          | Options           |
| --------------------- | ------------- | ----------------- |
| name                  | string        | null: false       |
| price                 | integer       | null: false       |
| image                 | ActiveStorage | null: false       |
| info                  | text          | null: false       |
| category_id           | integer       | null: false       |
| sales_status_id       | integer       | null: false       |
| fee_status_id         | integer       | null: false       |
| prefecture_id         | integer       | null: false       |
| scheduled_delivery_id | integer       | null: false       |
| user                  | references    |                   |

### Association

- belongs_to :user
- has_one :shopping_address

## shopping_addresses テーブル

| Column                | Type          | Options           |
| --------------------- | ------------- | ----------------- |
| postal_code           | string        | null: false       |
| prefecture_id         | integer       | null: false       |
| city                  | string        | null: false       |
| addresses             | string        | null: false       |
| building              | string        |                   |
| phone_number          | string        | null: false       |
| item                  | references    |                   |

### Association

- belongs_to :item
- belongs_to :user