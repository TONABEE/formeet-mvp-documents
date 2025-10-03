-- サンプルデータ.sql
-- Formeet MVP用サンプルデータ

-- ユーザーテーブルのサンプルデータ
INSERT INTO users (id, name, email, created_at) VALUES
(1, 'テストユーザー1', 'test1@example.com', NOW()),
(2, 'テストユーザー2', 'test2@example.com', NOW());

-- カテゴリテーブルのサンプルデータ
INSERT INTO categories (id, name, color, created_at) VALUES
(1, '仕事', '#FF5733', NOW()),
(2, '個人', '#33A8FF', NOW()),
(3, '健康', '#33FF57', NOW());

-- タスクテーブルのサンプルデータ
INSERT INTO tasks (id, user_id, title, description, priority, status, created_at) VALUES
(1, 1, 'プレゼン資料作成', '来週のプレゼン資料を作成する', 'HIGH', 'TODO', NOW()),
(2, 1, '運動', '30分のランニング', 'MEDIUM', 'TODO', NOW()),
(3, 1, '読書', '技術書を読む', 'LOW', 'COMPLETED', NOW());

-- ルーティンテーブルのサンプルデータ
INSERT INTO routines (id, user_id, name, time, days_of_week, created_at) VALUES
(1, 1, 'モーニングルーティン', '07:00', 'MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY', NOW()),
(2, 1, '夜のルーティン', '22:00', 'SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY', NOW());

-- スケジュールテーブルのサンプルデータ
INSERT INTO schedules (id, user_id, task_id, scheduled_date, scheduled_time, created_at) VALUES
(1, 1, 1, '2024-10-01', '10:00', NOW()),
(2, 1, 2, '2024-10-01', '18:00', NOW());