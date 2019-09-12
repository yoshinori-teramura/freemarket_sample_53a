# README


## users table
|column|type|options|
|------|----|-------|
|nickname            |string  |null: false, unique: true |
|family_name         |string  |null: false |
|first_name          |string  |null: false |
|family_kana_name    |string  |null: false |
|first_kana_name     |string  |null: false |
|birthday            |datetime|null: false |
|tel                 |integer |null: false, unique: true | 
|profile             |text    |
|credit              |references  |null: false, foreign_key: true |

### Association
- has_many :items
- has_one :credit
- has_one :address
- has_many :item_likes


## addresses
|column|type|options|
|------|----|-------|
<!-- |user_id             |references |null: false, foreign_key: true | -->
|postal_code         |integer    |null: false |
|prefecture          |string     |null: false |
|city                |string     |null: false |
|block               |integer    |null: false |
|building_name       |string     |

### Association
- belongs_to :user


## credits table
|colum|type|options|
|-----|----|-------|
|user_id             |references |null: false, foreign_key: true |
|number              |integer    |null: false, unique: true |
|name                |string     |null: false |
|expiration_date     |integer    |null: false |

### Association
- belongs_to :user

## items table
|column|type|options|
|------|----|-------|
|user_id           |references |null: false, foreign_key: true |
|name              |string  |null: false |
|description       |text    |null: false |
|category_id       |references |null: false, foreign_key: true |
|brand_id          |references |null: false, foreign_key: true |
|item_status       |integer  |null: false |
|shipping_charge   |integer  |null: false |
|delivery_region   |string   |null: false |
|delivery_days     |integer  |null: false |
|price             |integer  |null: false |
|trade_status      |integer  |null: false |


### association
- has_many :photos
- belongs_to :item_likes
- belongs_to :user
- belongs_to :categorys
- belongs_to :brands



## photos table

|Column|Type|Options|
|------|----|-------|
|item_id            |references    |null: false, foreign_key: true    |
|image              |string        |null: false|

### Association
- belongs_to :item

## categorys table
|Column|Type|Options|
|------|----|-------|
|name  |string      |null: false, unique: true  |

### Association
- has_many :items

## brands table
|Column|Type|Options|
|------|----|-------|
|name  |string      |null: false, unique: true  |

### Association
- has_many :items

## item_likes table
|Column|Type|Options|
|------|----|-------|
|item_id            |references |null: false, foreign_key: true |
|user_id            |references |null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user

