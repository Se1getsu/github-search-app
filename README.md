# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 環境

- IDE：Xcode 15.1（最新の安定版）
- Swift：Swift 5.9.2（最新の安定版）
- 開発ターゲット：iOS 17.2（最新の安定版）
- 使用ライブラリ：SwiftLint, Alamofire
- ライブラリ管理：Swift Package Manager

## アプリ仕様

本アプリは GitHub のリポジトリを検索するアプリです。

画面上部の検索バーにキーワードを入力すると、結果の一覧（リポジトリ名）が表示され、それをタップすると、リポジトリのより詳細な情報を確認することができます。

![動作イメージ](README_Images/app.gif)

### 新機能１：リポジトリの並び替え

検索画面の右上の設定ボタンから、検索結果のリポジトリの並び順を指定できるようにしました。

![動作イメージ](README_Images/feature_sort.gif)

### 新機能２：リポジトリをブラウザで開く

リポジトリの詳細画面の右上のボタンから、そのリポジトリの GitHub のページをブラウザで開けるようにしました。

![動作イメージ](README_Images/feature_browse.gif)

### アプリアイコンの作成
iPad アプリ『[アイビスペイントＸ](https://apps.apple.com/jp/app/%E3%82%A2%E3%82%A4%E3%83%93%E3%82%B9%E3%83%9A%E3%82%A4%E3%83%B3%E3%83%88x/id450722833?itsct=apps_box_link&itscg=30200)』を用いて、アプリアイコンを作成しました。

GitHub のアイコンをオマージュした黒丸から、検索を意味する虫眼鏡のシルエットを切り抜き、アプリのテーマカラーとして採用した紫色の背景に添えました。

![アイコンイメージ](README_Images/app_icon.png)

## 設計

### アーキテクチャ

本アプリでは、画面 (ViewController) の複雑さに応じて 2 種類の異なるアーキテクチャを使い分けています。
本アプリで実装している画面は、以下の 3 つです。

1. GitRepositorySearchView ... 検索画面
2. SearchSettingPopoverView ... 設定ボタンのポップオーバーの画面
3. GitRepositoryDetailView ... リポジトリの詳細画面

1 の画面には MVP アーキテクチャ、2, 3 の画面には MVC アーキテクチャを採用しました。

MVP では、プレゼンテーションロジックを ViewController ではなく Presenter に委譲する形で実装を行うため、画面を通じてのユーザーとのやり取りについての関心と、View-Model 間のデータのやり取りについての関心を分離することができ、プレゼンテーションロジックのテストが容易になります。

しかしコード量の増加という欠点も存在することから、簡単な画面では MVC を採用することにしました。

### プロジェクトツリー

ターゲット直下には、画面毎のグループを配置し、View, Presenter, Controller を画面ごとに分けて管理しています。

[`Model`](./iOSEngineerCodeCheck/Model) グループには、アーキテクチャによる分類上の Model にあたるものが入っています。

[`Model/Entity`](./iOSEngineerCodeCheck/Model/Entity) グループには、API 通信によって取得されるデータの構造体を定義しています。

[`Model/Error`](./iOSEngineerCodeCheck/Model/Error) グループには、Model のサービスが投げるエラーを定義しています。

[`Model/APIQuery`](./iOSEngineerCodeCheck/Model/APIQuery) グループには、GitHubAPI との通信に使用するクエリを定義しています。

[`Model/Service`](./iOSEngineerCodeCheck/Model/Service) グループには、Model が提供するサービスを定義しています。状態は持ちません。

[`View`](./iOSEngineerCodeCheck/View) グループには、再利用性が高く特定の画面に属することのない View が入っています。

[`Extension`](./iOSEngineerCodeCheck/Extension) グループには、既存のクラスや構造体に対する extension を記述したファイルが入っています。


## UI をブラッシュアップ

### 彩色

個人的に好きな紫色をテーマにして、UI に色をつけました。

UI に使用する色は、[AppColor.swift](./iOSEngineerCodeCheck/AppColor.swift) という 1 つのファイルの中に、`AppColor.background` や `AppColor.searchBarBarTint` といった文脈化された名前で定義しました。

できる限りシステムで用意されたダイナミックカラーを使用するために、Asset Catalog による管理はしていません。

システムの設定に応じて、ダークモードやハイコントラストにも対応しています。

![画面イメージ](README_Images/dynamic_color.png)

### レイアウト強化

様々な縦横比の画面でも、最適なレイアウトで UI が表示されるようにしました。

以下に、いくつかの例を示します。

iPhone 15 Pro 横画面：

![画面イメージ](README_Images/layout_iPhone.jpeg)

iPad Air (第５世代) 横画面 Split View：

![画面イメージ](README_Images/layout_iPad_1.jpeg)

iPad Air (第５世代) 縦画面 Slide Over：

![画面イメージ](README_Images/layout_iPad_2.jpeg)

上のようにリポジトリ名が画面幅の関係で表示しきれない場合は、スクロールして見ることができます。

## UX の改善

### 起動直後の案内表示

起動直後に表示される検索画面には何も表示するコンテンツがないため、ユーザーを困惑させないよう、画面上部の検索バーにキーワードを入力することを促す説明を表示するようにしました。

### 読み込み中の表示

[HIG](https://developer.apple.com/design/human-interface-guidelines/loading) に従い、コンテンツの読み込み中には代わりのものを表示し、読み込み中であることをユーザーが分かるようにしました。

まず、リポジトリの検索時には、アクティビティインジケーターを表示するようにしました。

![画面イメージ](README_Images/ux_activity_indicator.jpeg)

また、画像の読み込み時には、プレースホルダーを表示するようにしました。

![画面イメージ](README_Images/ux_image_loading.jpeg)

### 検索結果がない場合の表示

検索結果が 0 件の場合は「検索結果なし」の表示をするようにしました。

![画面イメージ](README_Images/ux_no_result.jpeg)

### エラー対処

何らかの原因で読み込みに失敗した場合には、ユーザーにその旨を伝えるようにしました。

![画面イメージ](README_Images/ux_no_connection.jpeg)

想定外のエラーが発生した場合には、NSError のエラーコードをアラートとして表示し、開発側が解決に取り組む際に最低限問題を分類しやすくしました。

また、リポジトリの画像のフェッチに失敗した場合には、プレースホルダーに「画像の取得に失敗しました」と表示するようにしました。

## 参考にしたもの

以下は、この課題に取り組むにあたって私が主に参考にしたものです。

### API 関連

- [検索 - GitHub Docs](https://docs.github.com/ja/rest/search/search?apiVersion=2022-11-28#search-repositories)

- [複雑な型の設定 - JSON Schema | nju33](https://nju33.com/notes/json-schema/articles/複雑な型の設定)

### UI 関連

- [UIStackView | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uistackview)

- [StackViewを賢く使ってらくちんAutoLayout #Swift - Qiita](https://qiita.com/yucovin/items/ff58fcbd60ca81de77cb)

- [UIScrollView | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiscrollview)

### HIG

- [Loading | Apple Developer Documentation](https://developer.apple.com/design/human-interface-guidelines/loading)

- [Popovers | Apple Developer Documentation](https://developer.apple.com/design/human-interface-guidelines/popovers)

### その他

- [私が（iOS エンジニアの）採用でコードチェックする時何を見ているのか #Swift - Qiita](https://qiita.com/lovee/items/d76c68341ec3e7beb611)
