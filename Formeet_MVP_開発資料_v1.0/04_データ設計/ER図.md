# Formeet データベース設計 (ER図)

## 作成日: 2025年9月30日
## 対象: Formeet 認知特性対応型ライフマネジメントアプリ MVP版
## データベース: PostgreSQL 15 + Redis

---

## エンティティ関連図 (Entity Relationship Diagram)

### 主要エンティティ一覧
```
1. Users (ユーザー)
2. Projects (プロジェクト)
3. Tasks (タスク)
4. Appointments (予定)
5. Routines (ルーティン)
6. TravelLogs (移動記録)
7. SleepLogs (睡眠記録)
8. Locations (場所マスタ)
9. TaskLogs (タスク実行ログ)
10. CognitiveAssessments (認知特性評価)
11. DailyReviews (日次振り返り)
12. UserSettings (ユーザー設定)
```

---

## 詳細テーブル設計

### 1. Users (ユーザーテーブル)
**説明**: 基本的なユーザーアカウント・設定情報
```sql
CREATE TABLE users (
    user_id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email           VARCHAR(255) UNIQUE NOT NULL,
    name            VARCHAR(50) NOT NULL,
    wake_time       TIME DEFAULT '07:00',
    bed_time        TIME DEFAULT '23:00',
    home_location   GEOGRAPHY(POINT, 4326),
    work_location   GEOGRAPHY(POINT, 4326),
    timezone        VARCHAR(50) DEFAULT 'Asia/Tokyo',
    status          VARCHAR(20) DEFAULT 'active',
    last_login_at   TIMESTAMP WITH TIME ZONE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

**関連性:**
- 1:N → Projects
- 1:N → Tasks
- 1:N → Appointments
- 1:N → Routines
- 1:N → SleepLogs
- 1:1 → CognitiveAssessments

---

### 2. Projects (プロジェクトテーブル)
**説明**: タスクのカテゴリ分類・色分け管理
```sql
CREATE TABLE projects (
    project_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    name            VARCHAR(100) NOT NULL,
    color           VARCHAR(7) NOT NULL, -- HEXカラー (#FF6B6B等)
    icon            VARCHAR(50), -- アイコン名
    display_order   INTEGER DEFAULT 0,
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 3. Tasks (タスクテーブル)
**説明**: ユーザーのタスク管理
```sql
CREATE TABLE tasks (
    task_id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    project_id      UUID REFERENCES projects(project_id) ON DELETE SET NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT,
    priority        INTEGER CHECK (priority IN (1, 2, 3)), -- 1:低 2:中 3:高
    estimated_minutes INTEGER, -- 予測所要時間
    actual_minutes  INTEGER, -- 実際の所要時間
    scheduled_date  DATE,
    scheduled_start TIMESTAMP WITH TIME ZONE,
    scheduled_end   TIMESTAMP WITH TIME ZONE,
    status          VARCHAR(20) DEFAULT 'todo', -- todo, doing, done, cancelled
    is_routine      BOOLEAN DEFAULT FALSE,
    routine_type    VARCHAR(20), -- morning, night
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at    TIMESTAMP WITH TIME ZONE
);
```

**関連性:**
- N:1 → Users
- N:1 → Projects
- 1:N → TaskLogs

---

### 4. Appointments (予定テーブル)
**説明**: ユーザーの予定・会議管理
```sql
CREATE TABLE appointments (
    appointment_id  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    title           VARCHAR(200) NOT NULL,
    description     TEXT,
    start_time      TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time        TIMESTAMP WITH TIME ZONE NOT NULL,
    location_type   VARCHAR(20) DEFAULT 'f2f', -- f2f, online, hybrid
    location_name   VARCHAR(200),
    address         TEXT,
    latitude        DECIMAL(10, 8),
    longitude       DECIMAL(11, 8),
    meeting_url     VARCHAR(500),
    preparation_minutes INTEGER DEFAULT 0, -- 準備時間
    buffer_minutes  INTEGER DEFAULT 0, -- バッファ時間
    is_recurring    BOOLEAN DEFAULT FALSE,
    recurrence_rule TEXT, -- RRULE形式
    status          VARCHAR(20) DEFAULT 'scheduled', -- scheduled, completed, cancelled
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 5. Routines (ルーティンテーブル)
**説明**: 朝・夜のルーティンタスク管理
```sql
CREATE TABLE routines (
    routine_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    name            VARCHAR(100) NOT NULL,
    type            VARCHAR(20) NOT NULL, -- morning, night
    estimated_minutes INTEGER NOT NULL,
    display_order   INTEGER DEFAULT 0,
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 4. Interests (興味・趣味マスタ)
**説明**: 興味・趣味のカテゴリマスタ
```sql
CREATE TABLE interests (
    interest_id     SERIAL PRIMARY KEY,
    name            VARCHAR(50) UNIQUE NOT NULL,
    category        VARCHAR(30), -- sports, music, travel, food, etc.
    icon_url        VARCHAR(300),
    display_order   INTEGER DEFAULT 0,
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**関連性:**
- 1:N → UserInterests

---

### 5. UserInterests (ユーザー興味関連)
**説明**: ユーザーと興味・趣味の関連テーブル
```sql
CREATE TABLE user_interests (
    user_interest_id SERIAL PRIMARY KEY,
    user_id         INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    interest_id     INTEGER REFERENCES interests(interest_id) ON DELETE CASCADE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, interest_id)
);
```

### 6. TravelLogs (移動記録テーブル)
**説明**: GPS追跡による移動実績・学習データ
```sql
CREATE TABLE travel_logs (
    travel_log_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    appointment_id  UUID REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    origin_name     VARCHAR(200),
    origin_lat      DECIMAL(10, 8),
    origin_lng      DECIMAL(11, 8),
    destination_name VARCHAR(200),
    destination_lat DECIMAL(10, 8),
    destination_lng DECIMAL(11, 8),
    planned_departure TIMESTAMP WITH TIME ZONE,
    actual_departure TIMESTAMP WITH TIME ZONE,
    planned_arrival TIMESTAMP WITH TIME ZONE,
    actual_arrival  TIMESTAMP WITH TIME ZONE,
    planned_duration INTEGER, -- 分
    actual_duration INTEGER, -- 分
    transport_mode  VARCHAR(20), -- walking, transit, driving
    delay_minutes   INTEGER GENERATED ALWAYS AS (actual_duration - planned_duration) STORED,
    weather_condition VARCHAR(50),
    day_of_week     INTEGER,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 7. SleepLogs (睡眠記録テーブル)
**説明**: ルーティンベースの睡眠パターン記録
```sql
CREATE TABLE sleep_logs (
    sleep_log_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    date            DATE NOT NULL,
    bedtime         TIMESTAMP WITH TIME ZONE, -- 夜ルーティン完了時刻
    wake_time       TIMESTAMP WITH TIME ZONE, -- 朝ルーティン開始時刻
    sleep_duration  INTEGER GENERATED ALWAYS AS (
        EXTRACT(EPOCH FROM (wake_time - bedtime)) / 60
    ) STORED, -- 分
    sleep_quality   INTEGER CHECK (sleep_quality BETWEEN 1 AND 5),
    notes           TEXT,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, date)
);
```

### 8. Locations (場所マスタテーブル)
**説明**: よく使う場所の管理
```sql
CREATE TABLE locations (
    location_id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    name            VARCHAR(100) NOT NULL,
    address         TEXT,
    latitude        DECIMAL(10, 8),
    longitude       DECIMAL(11, 8),
    location_type   VARCHAR(20), -- home, work, frequent
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 9. TaskLogs (タスク実行ログテーブル)
**説明**: タスク実行の詳細記録・分析用
```sql
CREATE TABLE task_logs (
    log_id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    task_id         UUID REFERENCES tasks(task_id) ON DELETE CASCADE,
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    action_type     VARCHAR(20) NOT NULL, -- start, pause, resume, complete, cancel
    timestamp       TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    location_lat    DECIMAL(10, 8),
    location_lng    DECIMAL(11, 8),
    notes           TEXT,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 10. CognitiveAssessments (認知特性評価テーブル)
**説明**: 初期アンケート・継続的評価結果
```sql
CREATE TABLE cognitive_assessments (
    assessment_id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    assessment_type VARCHAR(20) DEFAULT 'initial', -- initial, periodic
    responses       JSONB NOT NULL, -- アンケート回答データ
    scores          JSONB, -- 計算されたスコア
    cognitive_type  VARCHAR(20), -- adhd, asd, border, neurotypical
    confidence_level DECIMAL(3,2), -- 0.00-1.00
    recommendations JSONB, -- 個別推奨機能
    assessed_at     TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 11. DailyReviews (日次振り返りテーブル)
**説明**: 毎日の振り返り・改善記録
```sql
CREATE TABLE daily_reviews (
    review_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    review_date     DATE NOT NULL,
    task_completion_rate DECIMAL(5,2), -- パーセンテージ
    schedule_adherence DECIMAL(5,2), -- スケジュール遵守率
    mood_score      INTEGER CHECK (mood_score BETWEEN 1 AND 5),
    energy_level    INTEGER CHECK (energy_level BETWEEN 1 AND 5),
    challenges      JSONB, -- その日の困難・課題
    successes       JSONB, -- その日の成功・良かったこと
    improvements    JSONB, -- 明日への改善点
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, review_date)
);
```

### 12. UserSettings (ユーザー設定テーブル)
**説明**: アプリ設定・個人化設定
```sql
CREATE TABLE user_settings (
    setting_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES users(user_id) ON DELETE CASCADE,
    notification_enabled BOOLEAN DEFAULT TRUE,
    notification_types JSONB DEFAULT '{"task":true,"travel":true,"routine":true}',
    gps_accuracy    VARCHAR(20) DEFAULT 'balanced', -- high, balanced, low
    theme           VARCHAR(20) DEFAULT 'system', -- light, dark, system
    font_size       VARCHAR(20) DEFAULT 'medium', -- small, medium, large
    language        VARCHAR(10) DEFAULT 'ja',
    timezone_auto   BOOLEAN DEFAULT TRUE,
    data_sync_wifi_only BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id)
);
```

### 7. Matches (マッチングテーブル)
**説明**: 相互いいねによるマッチング管理
```sql
CREATE TABLE matches (
    match_id        SERIAL PRIMARY KEY,
    user1_id        INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    user2_id        INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    matched_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(20) DEFAULT 'active', -- active, deleted
    CHECK (user1_id < user2_id) -- 順序の統一
);
```

**関連性:**
- N:1 → Users (user1_id)
- N:1 → Users (user2_id)
- 1:1 → ChatRooms

**インデックス:**
- `(user1_id, user2_id)` (UNIQUE)
- `(user2_id, user1_id)`

---

### 8. ChatRooms (チャットルーム)
**説明**: マッチング後のチャットルーム管理
```sql
CREATE TABLE chat_rooms (
    room_id         SERIAL PRIMARY KEY,
    match_id        INTEGER UNIQUE REFERENCES matches(match_id) ON DELETE CASCADE,
    last_message_at TIMESTAMP,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**関連性:**
- 1:1 → Matches
- 1:N → Messages

---

### 9. Messages (メッセージテーブル)
**説明**: チャット内のメッセージ管理
```sql
CREATE TABLE messages (
    message_id      SERIAL PRIMARY KEY,
    room_id         INTEGER REFERENCES chat_rooms(room_id) ON DELETE CASCADE,
    from_user_id    INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    message_type    VARCHAR(20) DEFAULT 'text', -- text, image, system
    content         TEXT,
    image_url       VARCHAR(500),
    is_read         BOOLEAN DEFAULT FALSE,
    sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**関連性:**
- N:1 → ChatRooms
- N:1 → Users (from_user_id)

**インデックス:**
- `(room_id, sent_at)`
- `(from_user_id, sent_at)`

---

### 10. Reports (通報テーブル)
**説明**: ユーザー・コンテンツ通報管理
```sql
CREATE TABLE reports (
    report_id       SERIAL PRIMARY KEY,
    reporter_id     INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    reported_user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    report_type     VARCHAR(30) NOT NULL, -- harassment, fake_profile, spam, etc.
    reason          TEXT,
    status          VARCHAR(20) DEFAULT 'pending', -- pending, investigating, resolved, dismissed
    admin_notes     TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at     TIMESTAMP
);
```

**関連性:**
- N:1 → Users (reporter_id)
- N:1 → Users (reported_user_id)

---

### 11. Blocks (ブロックテーブル)
**説明**: ユーザー間のブロック管理
```sql
CREATE TABLE blocks (
    block_id        SERIAL PRIMARY KEY,
    blocker_id      INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    blocked_id      INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    reason          VARCHAR(50),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(blocker_id, blocked_id)
);
```

**関連性:**
- N:1 → Users (blocker_id)
- N:1 → Users (blocked_id)

---

### 12. Verifications (本人確認テーブル)
**説明**: 本人確認書類・ステータス管理
```sql
CREATE TABLE verifications (
    verification_id SERIAL PRIMARY KEY,
    user_id         INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    document_type   VARCHAR(30), -- drivers_license, passport, id_card
    document_url    VARCHAR(500),
    selfie_url      VARCHAR(500),
    status          VARCHAR(20) DEFAULT 'pending', -- pending, approved, rejected
    admin_notes     TEXT,
    submitted_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_at     TIMESTAMP,
    reviewed_by     INTEGER -- 管理者ID（将来拡張）
);
```

---

## リレーションシップ詳細

### 主要な関連性
```
Users (1) ←→ (N) Projects
Users (1) ←→ (N) Tasks
Users (1) ←→ (N) Appointments
Users (1) ←→ (N) Routines
Users (1) ←→ (N) TravelLogs
Users (1) ←→ (N) SleepLogs
Users (1) ←→ (N) Locations
Users (1) ←→ (1) CognitiveAssessments
Users (1) ←→ (N) DailyReviews
Users (1) ←→ (1) UserSettings

Tasks (N) ←→ (1) Projects
Tasks (1) ←→ (N) TaskLogs
Appointments (1) ←→ (N) TravelLogs
```

### ビジネスルール
1. **ルーティン記録**: 朝ルーティン開始=起床、夜ルーティン完了=就寝として記録
2. **GPS追跡**: 移動予定の前後30分のみ高精度、それ以外は低頻度
3. **タスク優先度**: 期限>短時間>重要度の順で自動計算
4. **認知特性評価**: 初回必須、その後3ヶ月毎の定期評価
5. **データ保持**: 個人情報は暗号化、位置情報は3ヶ月で自動削除

---

## インデックス戦略

### パフォーマンス最適化
```sql
-- タスク・スケジュール関連
CREATE INDEX idx_tasks_user_date ON tasks(user_id, scheduled_date);
CREATE INDEX idx_tasks_status ON tasks(status, priority);
CREATE INDEX idx_appointments_user_time ON appointments(user_id, start_time);
CREATE INDEX idx_routines_user_type ON routines(user_id, type, display_order);

-- 位置情報・GPS関連
CREATE INDEX idx_travel_logs_user_date ON travel_logs(user_id, actual_departure);
CREATE INDEX idx_travel_logs_route ON travel_logs(origin_lat, origin_lng, destination_lat, destination_lng);
CREATE INDEX idx_locations_user_type ON locations(user_id, location_type);

-- 分析・レポート関連
CREATE INDEX idx_sleep_logs_user_date ON sleep_logs(user_id, date);
CREATE INDEX idx_daily_reviews_user_date ON daily_reviews(user_id, review_date);
CREATE INDEX idx_task_logs_user_time ON task_logs(user_id, timestamp);

-- 地理情報インデックス（PostGIS）
CREATE INDEX idx_users_home_location ON users USING GIST(home_location);
CREATE INDEX idx_users_work_location ON users USING GIST(work_location);
```

---

## データ整合性制約

### CHECK制約
```sql
-- 時間関連の制約
ALTER TABLE tasks ADD CONSTRAINT check_estimated_minutes 
    CHECK (estimated_minutes > 0 AND estimated_minutes <= 1440); -- 最大24時間

ALTER TABLE appointments ADD CONSTRAINT check_appointment_duration 
    CHECK (end_time > start_time);

ALTER TABLE routines ADD CONSTRAINT check_routine_minutes 
    CHECK (estimated_minutes > 0 AND estimated_minutes <= 240); -- 最大4時間

-- 位置情報の制約
ALTER TABLE travel_logs ADD CONSTRAINT check_travel_duration 
    CHECK (actual_duration >= 0 AND actual_duration <= 1440); -- 最大24時間

-- 評価スコアの制約
ALTER TABLE daily_reviews ADD CONSTRAINT check_completion_rate 
    CHECK (task_completion_rate >= 0 AND task_completion_rate <= 100);

ALTER TABLE cognitive_assessments ADD CONSTRAINT check_confidence 
    CHECK (confidence_level >= 0 AND confidence_level <= 1);
```

### トリガー例
```sql
-- 睡眠ログ自動生成（ルーティン完了時）
CREATE OR REPLACE FUNCTION create_sleep_log_on_routine()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.routine_type = 'night' AND NEW.status = 'done' THEN
        -- 夜ルーティン完了時に就寝記録
        INSERT INTO sleep_logs (user_id, date, bedtime)
        VALUES (NEW.user_id, CURRENT_DATE, CURRENT_TIMESTAMP)
        ON CONFLICT (user_id, date) DO UPDATE SET bedtime = CURRENT_TIMESTAMP;
    ELSIF NEW.routine_type = 'morning' AND OLD.status != 'done' AND NEW.status = 'done' THEN
        -- 朝ルーティン開始時に起床記録
        UPDATE sleep_logs 
        SET wake_time = CURRENT_TIMESTAMP 
        WHERE user_id = NEW.user_id AND date = CURRENT_DATE - INTERVAL '1 day';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- タスク実行ログ自動記録
CREATE OR REPLACE FUNCTION log_task_action()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO task_logs (task_id, user_id, action_type, timestamp)
    VALUES (NEW.task_id, NEW.user_id, 
           CASE WHEN NEW.status = 'doing' THEN 'start'
                WHEN NEW.status = 'done' THEN 'complete'
                ELSE 'update'
           END, 
           CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

---

## セキュリティ考慮事項

### 個人情報保護
- パスワードハッシュ化必須
- メールアドレス・個人識別情報の適切な暗号化
- 位置情報の暗号化・アクセス制限
- 認知特性評価データの厳重な管理
- 移動履歴・行動パターンデータの匿名化

### データアクセス制御
- ユーザーは自分のデータのみアクセス可能
- 位置情報は必要時のみ取得・保存期間制限
- 認知特性データへの医療従事者以外のアクセス制限
- 管理者権限の適切な分離・監査ログ記録

### プライバシー保護
- GPS追跡の明示的な同意取得
- データ利用目的の透明性確保
- 個人の行動パターン分析結果の第三者提供禁止
- ユーザーによるデータ削除権の保障

---

**更新履歴:**
- 2025年9月30日: 初版作成
- 定期見直し: 開発進捗・要件変更に応じて更新