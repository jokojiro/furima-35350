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

## usersテーブル 

|Column--------------|Type----|Options---|
|nickname------------|string--|null:false|
|email---------------|string--|null:false|
|encrypted_password--|string--|null:false|
|last_name-----------|string--|null:false|
|first_name----------|string--|null:false|
|last_name_kana------|string--|null:false|
|first_name_kana-----|string--|null:false|
|birthday------------|date----|null:false|
### Association
has_many :items
has_many :buy
（ここに追記していく）

# itemsテーブル 
|Column----------|Type------|Options---------|
|name------------|string----|null:false------|
|description-----|string----|null:false------|
|category_id-----|integer---|null:false------|
|condition_id----|integer---|null:false------|
|shipping_id-----|integer---|null:false------|
|area_id---------|integer---|null:false------|
|delivery_days_id|integer---|null:false------|
|price-----------|integer---|null:false------|
|user------------|references|foreign_key:true|
### Association
belongs_to :user
has_one :buy

# buyテーブル 
|Column|Type--------|Options----------|
|user--|references--|foreign_key:true-|
|item--|references--|foreign_key:true-|
### Association
belongs_to :user
belongs_to :items
has_one :address

# addressテーブル 
|Column---------|Type------|Options----------|
|postal_code----|string----|null:false-------|
|prefecture_id--|string----|null:false-------|
|municipalities-|string----|null:false-------|
|address--------|string----|null:false-------|
|phone_number---|string----|null:false-------|
|building_name--|string----|null:false-------|
|buy------------|references|foreign_key:true-|

### Association
belongs_to :buy