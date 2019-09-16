# 概要
ライフステージに合った練馬区の行政情報を発信、共有するアプリケーション

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

# 使用技術一覧
## バックエンド
 * ruby 2.5.1
 * Ruby on Rails 5.2.3
 * Rspecでテスト(記事投稿機能のみ、Capybara)
 * テスト用データ作成(factory_bot)

## フロント
 * HTML、CSS、BootStrap(全体の見た目)
 * JavaScript(投稿時、カテゴリにチェックを入れると他のカテゴリにはチェックが入れられない仕様に)

## インフラ
 * heroku
 * Postgresql
  
# 今後の課題






This README would normally document whatever steps are necessary to get the
