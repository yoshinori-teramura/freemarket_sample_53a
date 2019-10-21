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
|tel                 |string  |null: false, unique: true |
|profile             |text    |
|credit              |references  |null: false, foreign_key: true |

### Association
- has_many :items
- has_one :credit
- has_one :address
- has_many :item_likes
= has_one :sns_credntials


## addresses
|column|type|options|
|------|----|-------|
|delivery_family_name|string     |null:false  |
|delivery_first_name |string     |null:false  |
|delivery_family_kana_name|string|null:false  |
|delivery_first_kana_name |string|null:fasle  |
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
|number              |string     |null: false, unique: true |
|expiration_date     |date       |null: false |
|security_code       |integer    |null: false |

### Association
- belongs_to :user

## items table
|column|type|options|
|------|----|-------|
|user_id           |references |null: false, foreign_key: true |
|name              |string  |null: false |
|description       |text    |null: false |
|category_id       |references |null: false, foreign_key: true |
|brand_id          |integer  ||
|item_status       |integer  |null: false |
|shipping_charge   |integer  |null: false |
|delivery_region   |integer  |null: false |
|delivery_type     |integer  |null: false |
|delivery_days     |integer  |null: false |
|price             |integer  |null: false |
|trade_status      |integer  |null: false |
|image             |string   ||

### association
- has_many :photos
- belongs_to :favorite
- belongs_to :user
- belongs_to :category


## photos table
|Column|Type|Options|
|------|----|-------|
|item_id            |references    |null: false, foreign_key: true    |
|image              |string        |null: false|

### Association
- belongs_to :item

## categories table
|Column|Type|Options|
|------|----|-------|
|name  |string      |null: false, unique: true  |
|ancestry|string    ||

### Association
- has_many :items

## brands table
|Column|Type|Options|
|------|----|-------|
|name  |string      |null: false, unique: true  |

### Association

## favorites table
|Column|Type|Options|
|------|----|-------|
|item_id            |references |null: false, foreign_key: true |
|user_id            |references |null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user

## buyers table
|Column|Type|Options|
|------|----|-------|
|item_id            |references |null: false, foreign_key: true |
|user_id            |references |null: false, foreign_key: true |
|status             |integer    |null:false|

### Association
- belongs_to :item
- belongs_to :user

## sns_credentials table
|Column|Type|Options|
|------|----|-------|
|user_id            |references |null: false, foreign_key: true |
|provider           |string     |
|uid                |string     |


### Association
- belongs_to :user
