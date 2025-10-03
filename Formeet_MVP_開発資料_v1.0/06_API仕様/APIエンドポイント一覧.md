# APIエンドポイント一覧.xlsx
## プレースホルダー

この位置にAPIエンドポイント一覧のExcelファイルを配置してください。

## 含むべきエンドポイント

### ユーザー関連
- GET /users - ユーザー情報取得
- POST /users - ユーザー登録
- PUT /users/{id} - ユーザー情報更新
- DELETE /users/{id} - ユーザー削除

### タスク関連
- GET /tasks - タスク一覧取得
- POST /tasks - タスク作成
- GET /tasks/{id} - タスク詳細取得
- PUT /tasks/{id} - タスク更新
- DELETE /tasks/{id} - タスク削除

### スケジュール関連
- GET /schedules - スケジュール取得
- POST /schedules - スケジュール作成
- PUT /schedules/{id} - スケジュール更新
- DELETE /schedules/{id} - スケジュール削除

### ルーティン関連
- GET /routines - ルーティン一覧取得
- POST /routines - ルーティン作成
- PUT /routines/{id} - ルーティン更新
- DELETE /routines/{id} - ルーティン削除

### カテゴリ関連
- GET /categories - カテゴリ一覧取得
- POST /categories - カテゴリ作成
- PUT /categories/{id} - カテゴリ更新
- DELETE /categories/{id} - カテゴリ削除

## 各エンドポイントの項目
- メソッド
- パス
- 説明
- リクエストパラメータ
- レスポンス形式
- ステータスコード