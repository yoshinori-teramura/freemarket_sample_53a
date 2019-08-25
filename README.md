# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...


## users table
|column|type|options|
|------|----|-------|
|nickname            |string  |unique: true |
|family_name         |string  |null: false |
|first_name          |string  |null: false |
|family_kana_name    |string  |null: false |
|first_kana_name     |string  |null: false |
|birthday            |integer |null: false |
|tel                 |integer |unique: true | 
|postal_code         |integer |null: false |
|prefectures         |string  |null: false |
|city                |string  |null: false |
|block               |integer |null: false |
|building_name       |string  |
|profile             |text    |
|item_id             |references  |null: false, foreign_key: true |
|credit              |references  |null: false, foreign_key: true |

### Association
- has_many :items
- belongs_to :credit
- has_many :items, through: :item_likes

## credits table
|colum|type|options|
|-----|----|-------|
|user_id             |references |null: false, foreign_key: true |
|credit_number       |integer  |null: false |

### Association
- belongs_to :user

## items table
|column|type|options|
|------|----|-------|
|photo_id          |references |null: false, foreign_key: true |
|name              |string  |null: false |
|description       |text    |null: false |
|category_id       |references |null: false, foreign_key: true |
|brand_id          |references |null: false, foreign_key: true |
|trade_status      |string  |null: false|
|shipping_charge   |string  |
|delivery_region   |string  |
|delivery_days     |string  |
|price             |integer |null: false |
|trade_status      |string  |


### association
- has_many :photos
- has_many :user, through: :item_likes
- belongs_to :user
- belongs_to :categorys
- belongs_to :brands

## photos table

|Column|Type|Options|
|------|----|-------|
|item_id            |references    |foreign_key: true    |
|image              |string        |

### Association
- belongs_to :item

## categorys table
|Column|Type|Options|
|------|----|-------|
|item_id             |references |foreign_key: true    |
|category_name       |string     |

### Association
- has_many :items

## brands table
|Column|Type|Options|
|------|----|-------|
|item_id             |references |foreign_key: true    |
|brand_name          |string     |

### Association
- has_many :items

## item_likes table
|Column|Type|Options|
|------|----|-------|
|item_id             |references |foreign_key: true    |
|user_id             |references |foreign_key: true    |

### Association
- belongs_to :item
- belongs_to :user