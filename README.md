# Live to Live

お笑いライブの「はしご」お助けサイト　Live to Live
https://www.livetolive.info/

***TestAccount:***

[email] shaka_shaka_hoteken@yahoo.co.jp
[password] testtest

## Description

ライブのはしごは時間との闘いになりがち。
毎日のライブの予定を把握し、それぞれの会場へのルートを事前に認識しておく必要があります。
Live to Liveは、ライブのはしごで忙しいあなたにスケジュール管理管理&経路検索を一度に可能とさせるサービスです。

## Features

- 単体テスト・統合テスト(RSpec)

- ライブ登録・編集機能
- amazonS3への画像データ保存
- ライブ削除機能（管理者）
- ライブの複数条件同時検索機能（gem ransack)
- ライブ出演者のタグ付け検索機能
- ライブ情報Twitterシェア機能

- 会員登録・ログイン機能(gem devise)
- Googleログイン機能(gem omniauth-google-oauth2)
- モーダルでの会員情報編集機能

- ライブの非同期お気に入り・カレンダー登録
- カレンダー登録したライブをマイページに表示する機能(gem fullcalendar)
- 現在地からライブ会場までの経路検索機能（目的地の緯度経度をパラメータにしてGoogleMAP外部サイトへ遷移）

- 週次の人気ライブTOP10メール送信機能（gem whenever & cron）
- お問い合わせメール送信機能

- ライブ会場の地図表示機能（GoogleMapAPI）
- ライブ会場500m以内のひまつぶしカフェ表示機能（GooglePlaceAPI）
- ライブ会場登録・編集機能
- ライブ会場登録時の緯度経度自動算出機能（GoogleGeocodingAPI）
- 現在地周辺3kmのライブ会場検索機能（GeolocationAPI & gem geokit）


## Requirement

ruby 2.3.8  
rails 5.2.3
