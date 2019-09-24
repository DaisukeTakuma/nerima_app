# 概要
 * ライフステージごとに、練馬区の使える行政情報を発信、共有するアプリケーション
 * 制作期間：3〜4週間
 * 制作中に意識したこと：railsの仕組みとエラー文から、問題を切り分けて調べずに解決する
 * https://www.suketaku-dev.com/ 管理者用 ID：admin@example.com / Pass：password
 
![スクリーンショット 2019-09-25 7 17 54](https://user-images.githubusercontent.com/52105565/65554489-b2bd8800-df64-11e9-9e24-796312972699.png)

# 機能一覧(かっこ内はgem名)
 * 記事投稿、記事コメント、画像アップロード
 * 記事詳細投稿
 * 記事一覧表示
 * カテゴリごと記事一覧表示
 * URLをリンク表示(rails_autolink)
 
 * ユーザー登録、管理者権限の付与(パスワード暗号化でbcrypt)
 * ログイン、マイページ
 * ログインユーザーの記事、コメント一覧表示
 * ユーザー編集、ユーザー退会
 
 * ページネーション(kaminari)
 * 記事タイトルからの検索(ransack)
 * フォロー機能(ajax対応)
 * いいね機能(ajax対応、counter_culture)

# クラウドアーキテクチャ
 ![Untitled Diagram (2)](https://user-images.githubusercontent.com/52105565/65554127-a127b080-df63-11e9-96da-6bd7a316df57.jpg)

# 使用技術一覧
## バックエンド,インフラ
 * ruby 2.5.1
 * Ruby on Rails 5.2.3
 * Rspecでテスト(記事投稿機能のみ、Capybara)
 * テスト用データ作成(factory_bot)
 * EC2、ALB、RDS、ACM(SSL証明書)
 * Docker(Railsアプリの基盤)

## フロント
 * HTML、CSS、BootStrap(全体の見た目)
 * JavaScript(投稿時、カテゴリにチェックを入れると他のカテゴリにはチェックが入れられない仕様に)

# 今後の課題
 * Rspecによるテスト実装
 * フロントエンドの改良 
 * CIツールの導入
