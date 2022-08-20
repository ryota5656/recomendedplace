# グーグルプレイスチャレンジ
【Home】
<img width="1676" alt="スクリーンショット 2022-08-21 0 06 06" src="https://user-images.githubusercontent.com/90943612/185753820-858a5997-478f-403d-bbba-baf1de451c11.png">
マップ上にピンをさし条件を入力して検索
<img width="1678" alt="スクリーンショット 2022-08-21 0 07 33" src="https://user-images.githubusercontent.com/90943612/185753912-49ef14be-e9df-448f-ad77-91e2f3a418d3.png">
ピン周辺の条件に合った検索結果が３つ表示される

【Myplace】
<img width="1678" alt="スクリーンショット 2022-08-21 0 09 27" src="https://user-images.githubusercontent.com/90943612/185753917-a4b8aa06-cbdf-487e-8765-d74c7442f107.png">
評価・コメント・お気に入り登録ができる

【Allplace】
<img width="1672" alt="スクリーンショット 2022-08-21 0 10 30" src="https://user-images.githubusercontent.com/90943612/185753928-a5ec38a6-cf87-4aaf-b251-6881eac7181f.png">
お気に入りした場所を共有できる

### サイト概要
条件を指定してGoogleから周辺の場所３つ候補を提案してくれるアプリです。  
口コミ等に流されずチャレンジ感覚でその場所に行ってみることができます。
### サイトテーマ
チャレンジゲーム感覚　行ったことない場所に行ってみよう
### テーマを選んだ理由
どこか行こうとネット検索して探すと口コミありきの場所探しになってしまい、評価が少ない店や低い店に行くことに億劫になり結局自分が気になった人気店に行ってしまう。  
自分の知らない世界を知るには誰かに選んでもらう必要があると考え、そこでgoogleにランダムに選んでもらったら良くも悪くもいろんなところ・経験ができると考え制作しました。

### ターゲットユーザ
- 年齢：１０代〜３０代
- 性別：男女問わない
- 出かけることが好きな人
- 行き先を誰かに決めてもらいたい人

### 主な利用シーン
- 自分では選ばないような場所にチャレンジ感覚で行ってみたいとき
- 予定はないけれど外に出たいとき
- 飲み会の場所探しに悩んでいるとき

### 機能一覧
- ユーザーの新規登録・退会・ログイン・ログアウト・編集機能
- google map APIを使用した位置情報の取得
- google place APIを使用した場所情報の取得
- 上記APIを使用し条件を付加した検索・場所の登録機能
- 登録した場所の評価・コメント・お気に入り登録機能及び編集機能
- 評価した場所をgoogle map上に表示し共有する機能

### 取り入れた技術
- 環境構築にDocker・Docker-Composeを使用
- RuboCopを用いて静的解析を実施
- RSpecでテストを実施
- Herokuでデプロイを実施
- Circle CIで自動テスト・自動デプロイ
- google APIを用いた位置情報・周辺情報の取得
- amazon AWS S3を用いたストレージ管理

### インフラ構成図
![名称未設定 drawio](https://user-images.githubusercontent.com/90943612/185370892-372ab1eb-db14-4d2d-a38f-53adba2b22cc.png)
### ER図
<img width="1156" alt="スクリーンショット 2022-08-20 23 55 09" src="https://user-images.githubusercontent.com/90943612/185752771-9cdd7c22-7979-4e7a-b5ff-99c963e24c2b.png">

### サイトマップ
![recomendedplace_app@1 7999999523162842x](https://user-images.githubusercontent.com/90943612/185751512-92f466d2-41cb-40c2-a8d2-1016c7a6d441.jpeg)
### 開発環境
- OS：macOS Monteley
- Docker / Docker-Compose
- 言語：HTML, CSS, JavaScript, Ruby, SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Visual Studio Code
