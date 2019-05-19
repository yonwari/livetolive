# Live to Live

お笑いライブの「はしご」お助けサイト　Live to Live
https://www.livetolive.info/

## 概要

ライブのはしごは時間との闘いになりがち。  
毎日のライブの予定を把握し、それぞれの会場へのルートを事前に認識しておく必要があります。  
Live to Liveは、ライブのはしごで忙しいあなたにスケジュール管理管理&経路検索を一度に可能とさせるサービスです。  

***テスト用アカウント***  
(アカウント情報入力不要の、ワンクリックログイン機能もご用意しております)

[email] test1@gmail.com  
[password] testtest  


## 機能
- ライブ登録・編集・（管理者のみ）削除機能  
  
- ライブの複数条件同時検索機能（gem ransack)
- ライブ出演者のタグ付け検索機能
- ライブ情報Twitterシェア機能
- ライブ情報の無限スクロール表示  

- 会員登録・編集・ログイン機能(gem devise)
- Googleログイン機能(gem omniauth-google-oauth2)

- ライブの非同期お気に入り・カレンダー登録(gem fullcalendar)
- 現在地からライブ会場までの経路検索機能（目的地の緯度経度をパラメータにしてGoogleMAP外部サイトへ遷移）

- 週次の人気ライブTOP10メール送信機能（gem whenever & cron）
- 日次の当日ライブ通知機能（gem whenever & cron）
- お問い合わせメール送信機能

- ライブ会場の地図表示機能（GoogleMapAPI）
- ライブ会場半径500m以内のひまつぶしカフェ表示機能（GooglePlaceAPI）
- ライブ会場登録・編集機能
- ライブ会場登録時の緯度経度自動算出機能（GoogleGeocodingAPI）
- 現在地周辺3kmのライブ会場検索機能（GeolocationAPI & gem geokit）


## 技術
- 単体テスト・統合テスト(RSpec)
- amazonS3への画像アップロード
- AWS EC2, Route53, ACM


## 言語・フレームワーク
ruby 2.3.8  
rails 5.2.3
