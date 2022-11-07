# Coffee_Record

## サイトイメージ
![image](https://user-images.githubusercontent.com/108636180/200107599-efe5968b-1f3a-48d5-8a8b-1de6c94db13f.png)

## サイト概要
### サイトテーマ
ご自身の好きな珈琲を投稿し、記録することができます。更に、珈琲が好きな人が他の人と珈琲の調合・配合などを共有することができ、互いに新たな知識を知ることができるコミュニティ系サイトです。

### テーマを選んだ理由
大人の人がカフェでパソコンを使って作業しながら珈琲を飲む姿に憧れを抱き、自分もこんな大人になりたいと思い、珈琲を飲み始めました。次第に珈琲について追求したいと思い、珈琲豆や珈琲の淹れ方などを調べるようになりました。

自分だけではなく、他にも珈琲が好きな人は少なくないと思います。中には珈琲豆や淹れ方に拘りがある人もいらっしゃると思うので、他の人と珈琲の調合・配合などを共有し合い、自分が知らない知識を新たに知りたいと思いました。

そこで、ご自身が好きな珈琲の調合・配合を投稿し、他の人と共有し合い、互いに新たな知識を得ることが出来るようなアプリケーションを開発することで、このアプリケーションをご利用される皆様の役に立たてればと思いこのテーマにしました。


### ターゲットユーザ
* 珈琲が好きな人
* 珈琲の調合・配合に興味がある人
* 好みの珈琲を他の人と共有したい人

### 主な利用シーン
* 好みの珈琲を他の人と共有したい時
* 他の人の調合・配合を真似したい時
* 新たな珈琲の知識を知りたい時

## 設計書

* ### [ER図](https://user-images.githubusercontent.com/108636180/199973176-82c4d3d4-b161-4f32-994f-44c0f60c838c.png)

* ### [テーブル定義書](https://docs.google.com/spreadsheets/d/1HgHYSwYrOHEXSg3zsc3QAhnfIDWnsQ1O2WPpUd8uE3Y/edit?usp=sharing)

* ### [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1d5J1AhK0zb-jNA6F9Lsxc0k5jqCvYsQO-6RSciXMhPE/edit?usp=sharing)


## 開発環境

* OS：Linux(CentOS)

* 言語：HTML,CSS,JavaScript,Ruby,SQL

* フレームワーク：Ruby on Rails

* JSライブラリ：jQuery

* IDE：Cloud9


## Gem

* gem "devise"
* gem "jquery-rails"
* gem "kaminari", "~> 1.2", ">= 1.2.1"
* gem "bootstrap5-kaminari-views", "~> 0.0.1"
* gem "enum_help"
* gem "rails-i18n"
* gem "dotenv-rails"
* gem "mysql2"


## 機能一覧

### 会員側
* ゲストログイン機能
* 会員機能
* 投稿機能
* 投稿の公開or下書き設定機能
* お気に入り機能（非同期通信化）
* コメント機能（非同期通信化）
* フォロー機能（非同期通信化）
* お問い合わせ機能
* 通知機能（お気に入り、コメント、フォロー）
* キーワード検索機能（投稿名）
* タグ検索機能（珈琲の淹れ方）
* カテゴリ検索機能（珈琲の種類）
* ジャンル検索機能（珈琲豆の種類）

### 管理者側
* 管理者ログイン機能
* 会員管理機能
* 投稿管理機能
* コメント管理機能
* お問い合わせ管理機能
* タグ管理機能（珈琲の淹れ方）
* カテゴリ管理機能（珈琲の種類）
* ジャンル管理機能（珈琲豆の種類）
* キーワード検索機能（会員名、投稿名、コメント内容）


## 使用素材

* [ロゴ画像](https://www.canva.com/ja_jp/create/logos/)

* [投稿画像,会員画像](https://www.shopify.com/jp/tools/logo-maker)

* [アバウト画像](https://pixabay.com/ja/)