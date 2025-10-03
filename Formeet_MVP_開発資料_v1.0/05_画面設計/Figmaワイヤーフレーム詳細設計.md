# Formeet Figmaワイヤーフレーム詳細設計

## 作成日: 2025年9月30日
## 対象: Formeet 認知特性対応型ライフマネジメントアプリ MVP版
## Figma URL: [実際のFigmaリンクをここに配置]

---

## 📐 Design System 定義

### 🎨 Color Palette (Colors)

#### システム色
```
Primary Colors:
- Primary Blue: #2196F3 (メイン操作・CTA)
- Primary Dark: #1976D2 (ナビゲーション・ヘッダー)
- Primary Light: #BBDEFB (背景・サブエリア)

Secondary Colors:
- Success Green: #4CAF50 (完了・成功状態)
- Warning Orange: #FF9800 (注意・移動アラート)  
- Error Red: #F44336 (エラー・緊急状態)
- Info Purple: #9C27B0 (情報・ガイド)

Neutral Colors:
- Text Primary: #212121 (メインテキスト)
- Text Secondary: #757575 (補助テキスト)
- Background: #FAFAFA (背景)
- Surface: #FFFFFF (カード・パネル)
- Divider: #E0E0E0 (境界線)
```

#### プロジェクト色 (8色)
```
Project Colors:
- Red: #FF6B6B (緊急・重要)
- Orange: #FFB74D (仕事・業務)
- Yellow: #FFF176 (学習・スキルアップ)
- Green: #81C784 (健康・運動)
- Blue: #64B5F6 (趣味・娯楽)
- Purple: #BA68C8 (人間関係・コミュニケーション)
- Pink: #F06292 (家事・生活)
- Gray: #90A4AE (その他・未分類)
```

#### ルーティンモード専用色
```
Morning Mode:
- Background: Linear Gradient #FFF3E0 → #FFECB3 (朝日イメージ)
- Accent: #FF8F00 (朝日オレンジ)

Night Mode:
- Background: Linear Gradient #303F9F → #1A237E (夜空イメージ)
- Accent: #7986CB (月光ブルー)
- Text: #FFFFFF (夜間視認性)
```

### 📝 Typography (フォント定義)

#### フォントファミリー
```
日本語: Noto Sans JP
英数字: SF Pro Display (iOS) / Roboto (Android)
アクセシビリティ: UD デジタル教科書体 (オプション)
```

#### フォントサイズ・階層
```
認知特性配慮サイズ (通常より1.2倍大きく):
- H1 (Page Title): 32px / Bold / Line Height 40px
- H2 (Section Title): 28px / SemiBold / Line Height 36px  
- H3 (Card Title): 24px / Medium / Line Height 32px
- Body Large: 20px / Regular / Line Height 28px
- Body Medium: 18px / Regular / Line Height 26px
- Body Small: 16px / Regular / Line Height 24px
- Caption: 14px / Regular / Line Height 20px

ルーティンモード専用 (さらに大きく):
- Routine Title: 40px / Bold / Line Height 48px
- Routine Task: 32px / Medium / Line Height 40px
- Time Display: 28px / Regular / Line Height 36px
```

### 🔧 Components (共通コンポーネント)

#### ボタンコンポーネント
```
Primary Button:
- Size: 56px height (認知特性配慮で大きく)
- Border Radius: 12px
- Typography: 18px / SemiBold
- States: Default, Hover, Pressed, Disabled
- Colors: Primary Blue base

Secondary Button:
- Size: 48px height
- Style: Outline style
- Border: 2px solid Primary Blue
- Typography: 16px / Medium

Text Button:
- Size: 44px height  
- No background
- Typography: 16px / Medium
- Color: Primary Blue

Floating Action Button (FAB):
- Size: 64px × 64px (大きめ)
- Shadow: 4dp elevation
- Icon: 28px × 28px
```

#### カードコンポーネント
```
Task Card:
- Padding: 20px
- Border Radius: 16px
- Shadow: 2dp elevation
- Left Border: 4px (プロジェクト色)
- Components: 
  - Checkbox (40×40px 大きめ)
  - Title (20px)
  - Time (16px)
  - Priority Stars

Project Color Bar:
- Width: 4px
- Height: 100% of card
- Position: Left edge
- 8 color variations

Progress Bar:
- Height: 12px (通常より太く)
- Border Radius: 6px
- Background: #E0E0E0
- Fill: Project Color or Primary Blue
```

#### アイコンセット
```
認知特性対応アイコン (視認性重視):
- Size: 28×28px (通常より大きく)
- Style: Outlined (認識しやすい)
- Stroke: 2.5px (太め)

Main Icons:
- Home: house-outline
- Tasks: checkbox-outline  
- Calendar: calendar-outline
- Settings: cog-outline
- Profile: person-outline
- Location: location-outline
- Time: time-outline
- Notification: bell-outline

Action Icons:
- Add: plus-circle
- Edit: pencil
- Delete: trash-can
- Start: play-circle
- Pause: pause-circle
- Complete: check-circle
- GPS: crosshairs-gps

Status Icons:
- Success: check-circle (Green)
- Warning: alert-circle (Orange)  
- Error: close-circle (Red)
- Info: information (Blue)
```

---

## 📱 Screen Wireframes 詳細設計

### 📁 00_Onboarding

#### Onboarding_01 (認知特性について)
```
Layout Structure:
┌─────────────────────────────────┐
│ Skip Button                     │ ← 右上 (Text Button)
├─────────────────────────────────┤
│                                 │
│    [Illustration Area]          │ ← 240×180px イラスト
│    脳のアイコン + 多様性表現     │
│                                 │
├─────────────────────────────────┤
│         認知特性とは？           │ ← H1 (32px)
│                                 │
│ 「平均的な人」は存在しません。   │ ← Body Large (20px)
│ 脳や神経、認知の違いは           │   4行程度のシンプル説明
│ 個性です。                       │
│                                 │ 
│ このアプリは、あなたの特性に     │
│ 合わせて日常をサポートします。   │
├─────────────────────────────────┤
│    ○ ○ ● (Page Indicator)      │ ← 進捗表示
├─────────────────────────────────┤
│      [次へ] (Primary Button)    │ ← 56px height
└─────────────────────────────────┘

Design Notes:
- 背景: 柔らかいグラデーション (#FAFAFA → #F5F5F5)
- イラスト: 多様性を表現するカラフルな脳のイメージ
- 文字: 読みやすさ重視・専門用語回避
- ボタン: 画面下部固定・誤タップ防止の余白確保
```

#### Onboarding_02 (アプリの使い方)
```
Layout Structure:
┌─────────────────────────────────┐
│ Skip Button                     │ 
├─────────────────────────────────┤
│    [Feature Demo Animation]     │ ← 240×180px アニメーション
│    GPS追跡 → 時間学習 → 改善    │   実際の機能デモ
├─────────────────────────────────┤
│       あなた専用の学習機能       │ ← H1 (32px)
│                                 │
│ • GPS で移動時間を自動学習      │ ← Bullet Points
│ • AI があなたの特性を理解       │   Body Large (20px)
│ • 無理のないペースで改善        │   
├─────────────────────────────────┤
│    ○ ● ○ (Page Indicator)      │
├─────────────────────────────────┤
│      [次へ] (Primary Button)    │
└─────────────────────────────────┘

Design Notes:
- アニメーション: Lottie形式・3秒ループ
- Feature説明: 3つのポイントに絞込み
- 視覚的表現: アイコン+テキストで理解促進
```

#### Onboarding_03 (プライバシー保護)
```
Layout Structure:
┌─────────────────────────────────┐
│                                 │
├─────────────────────────────────┤
│    [Shield Icon + Lock]         │ ← セキュリティアイコン
│        盾のアイコン             │   120×120px
├─────────────────────────────────┤
│        安心・安全な利用          │ ← H1 (32px)
│                                 │
│ ✓ 位置情報は暗号化保存          │ ← Checkmark List
│ ✓ 個人データの第三者提供なし    │   Body Large (20px)
│ ✓ いつでもデータ削除可能        │   Green checkmarks
│                                 │
│   詳細は利用規約をご確認下さい   │ ← Link (underlined)
├─────────────────────────────────┤
│    ○ ○ ● (Page Indicator)      │
├─────────────────────────────────┤
│     [始める] (Primary Button)   │ ← CTA ボタン
└─────────────────────────────────┘

Design Notes:
- セキュリティ感: Shield icon + Blue/Green color
- 信頼性: Checkmark で安心感演出
- CTA: 「始める」で期待感醸成
```

### 📁 01_Design System/Initial Setup

#### Setup_01 (基本情報入力)
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る    基本情報設定    1/6   │ ← Navigation Header
├─────────────────────────────────┤
│                                 │
│        こんにちは！             │ ← H2 Greeting (28px)
│     基本的な設定をしましょう     │   Body Medium (18px)
│                                 │
├─────────────────────────────────┤
│  お名前（ニックネーム可）        │ ← Label (16px)
│  ┌─────────────────────────┐  │
│  │ 田中太郎                 │  │ ← Text Input Field
│  └─────────────────────────┘  │   56px height
│                                 │
│  起床時間                       │ ← Label (16px)  
│  ┌─────────────────────────┐  │
│  │      07:00              │  │ ← Time Picker
│  └─────────────────────────┘  │   Wheel picker style
│                                 │
│  就寝時間                       │ ← Label (16px)
│  ┌─────────────────────────┐  │ 
│  │      23:00              │  │ ← Time Picker
│  └─────────────────────────┘  │
├─────────────────────────────────┤
│                                 │
│      [次へ] (Primary Button)    │ ← 入力完了で有効化
└─────────────────────────────────┘

Design Notes:
- Progress: 6ステップ中の1番目を明示
- Input Fields: 認知特性配慮で大きめ・明確な境界線
- Time Picker: iOS/Android ネイティブ形式
- Validation: リアルタイムバリデーション
```

#### Setup_02 (場所登録)
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る    場所の登録      2/6   │
├─────────────────────────────────┤
│    よく行く場所を登録しましょう  │ ← H2 (28px)
│   移動時間の正確な計算に使います │   Body Medium (18px)
├─────────────────────────────────┤
│                                 │
│  🏠 自宅                       │ ← Icon + Label
│  ┌─────────────────────────┐  │
│  │ 東京都新宿区西新宿1-1-1  │  │ ← Address Input
│  └─────────────────────────┘  │   + Map Icon (地図選択)
│                                 │
│  🏢 職場・学校                 │ ← Icon + Label
│  ┌─────────────────────────┐  │
│  │ 東京都千代田区丸の内1-1-1│  │ ← Address Input  
│  └─────────────────────────┘  │   + Map Icon
│                                 │
│  📍 よく行く場所 (任意)         │ ← Optional section
│  ┌─────────────────────────┐  │
│  │ 場所を追加...            │  │ ← Optional Input
│  └─────────────────────────┘  │   (最大3箇所)
├─────────────────────────────────┤
│      [後で設定] [次へ]          │ ← Dual buttons
└─────────────────────────────────┘

Design Notes:
- Map Integration: Google Maps API連携
- Autocomplete: 住所自動補完機能
- Icons: 分かりやすい場所アイコン
- Optional: 「後で設定」で強制感を軽減
```

#### Setup_03 (ルーティン設定)
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る   ルーティン設定   3/6   │
├─────────────────────────────────┤
│      朝と夜のルーティンを        │ ← H2 (28px)  
│        設定しましょう            │   説明文
├─────────────────────────────────┤
│                                 │
│  🌅 朝のルーティン              │ ← Section Header
│                                 │
│  ✓ 洗顔・歯磨き     [5分▼]     │ ← Checkboxes + Duration
│  ✓ 着替え           [10分▼]    │   40×40px checkbox
│  ✓ 朝食             [20分▼]    │   Time dropdown
│  ✓ 身だしなみ       [10分▼]    │
│                                 │
│  + 項目を追加                   │ ← Add button (text style)
│                                 │
├─────────────────────────────────┤
│  🌙 夜のルーティン              │ ← Section Header
│                                 │
│  ✓ 入浴             [30分▼]    │ ← Same pattern
│  ✓ スキンケア       [10分▼]    │
│  ✓ 明日の準備       [15分▼]    │  
│  ✓ 読書・リラックス [20分▼]    │
│                                 │
│  + 項目を追加                   │
├─────────────────────────────────┤
│      [後で設定] [次へ]          │
└─────────────────────────────────┘

Design Notes:
- Default Items: 一般的なルーティンをプリセット
- Customizable: 追加・削除・時間調整可能
- Visual Hierarchy: 朝/夜で色分け (#FFF3E0 / #303F9F background)
```

#### Setup_04 (認知特性アンケート)
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る  特性チェック     4/6   │
├─────────────────────────────────┤
│       あなたの特性を            │ ← H2 (28px)
│      知らせてください            │   
├─────────────────────────────────┤
│                                 │
│  質問 1/10                      │ ← Progress indicator
│  ▓▓░░░░░░░░                     │   Progress bar
│                                 │
│  時間の見積もりについて         │ ← Question category
│                                 │
│  作業時間の予測は得意ですか？   │ ← H3 Question (24px)
│                                 │
│  ○ とても得意                  │ ← Radio buttons
│  ○ まあ得意                    │   大きめサイズ (32×32px)
│  ● 普通                        │   
│  ○ やや苦手                    │
│  ○ とても苦手                  │
│                                 │
├─────────────────────────────────┤
│             [次の質問]          │ ← Progress button
└─────────────────────────────────┘

Design Notes:  
- Question Flow: 10問×約1分で完了
- Categories: 時間感覚・注意力・マルチタスク・コミュニケーション
- Response Scale: 5段階 (分かりやすい表現)
- Progress: 視覚的進捗表示で安心感
```

#### Setup_05 (位置情報許可)
```  
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る  位置情報設定     5/6   │
├─────────────────────────────────┤
│                                 │
│    [GPS Illustration]           │ ← GPS衛星のイラスト
│      📍🛰️📱                   │   120×120px
│                                 │
├─────────────────────────────────┤
│      移動時間の学習機能          │ ← H2 (28px)
│                                 │
│  この機能により、あなたの        │ ← Body Large (20px)
│  移動パターンを学習し、          │   4-5行の説明
│  より正確な時間予測が            │
│  可能になります。                │
│                                 │
│  🔒 位置情報は暗号化され、       │ ← Security note
│     移動学習にのみ使用されます   │   with lock icon
├─────────────────────────────────┤
│     [許可する] (Primary)        │ ← Permission buttons
│                                 │
│    [手動で管理] (Secondary)     │ ← Alternative option
└─────────────────────────────────┘

Design Notes:
- Clear Benefit: 位置情報使用の価値を明確に説明  
- Privacy Emphasis: セキュリティ・プライバシー保護を強調
- Alternative: 強制感を与えない「手動管理」オプション
- Visual: GPS機能の分かりやすいイラスト
```

#### Setup_06 (設定完了)
```
Layout Structure:
┌─────────────────────────────────┐
│              6/6               │ ← Final step indicator
├─────────────────────────────────┤
│                                 │
│    [Success Illustration]       │ ← 完了・成功のイラスト
│         🎉✅🎯                 │   confetti animation
│                                 │
├─────────────────────────────────┤
│         設定完了！              │ ← H1 Success (32px)
│                                 │
│    Formeetの準備ができました     │ ← Body Large (20px)
│                                 │
│  まずは今日の計画を立てて、      │ ← Next step guidance
│  新しい一歩を踏み出しましょう！  │   
│                                 │
├─────────────────────────────────┤
│                                 │
│    [Formeetを始める]            │ ← Primary CTA button
│     (Primary Button)            │   
│                                 │
└─────────────────────────────────┘

Design Notes:
- Celebration: 完了感・達成感のある演出
- Animation: Confetti やチェックマークのアニメーション  
- Positive Tone: ポジティブなメッセージング
- Clear CTA: 次のステップへの明確な導線
```

### 📁 02_Screens/01_Main_Normal

#### Main_Normal_Dashboard
```
Layout Structure:
┌─────────────────────────────────┐
│  15:23  📍新宿  🔋85%  📶      │ ← Status Bar
├─────────────────────────────────┤
│  👤 田中さん          ⚙️ 📊   │ ← Header (name + settings)
├─────────────────────────────────┤
│                                 │
│         今日のフォーカス         │ ← H2 Section Title (28px)
│                                 │
│  ┌─────────────────────────┐  │ ← Current Block Card
│  │ 📝 資料作成 (実行中)    │  │   Elevated card
│  │                         │  │   
│  │ ▓▓▓▓▓▓░░░░ 60%        │  │   Progress bar
│  │ 残り 20分               │  │   Time remaining
│  │                         │  │
│  │    [完了]  [一時停止]   │  │   Action buttons
│  └─────────────────────────┘  │
│                                 │
│         次の予定                │ ← H3 Next Event (24px)
│                                 │
│  🚶‍♂️ 16:30 会議室A への移動    │ ← Movement alert
│     出発まで 27分               │   with walking icon
│                                 │
├─────────────────────────────────┤
│        今日のタスク             │ ← H3 Section (24px) 
│                     全て見る >   │   View all link
│                                 │
│  ✓ メール返信           完了    │ ← Task items
│  □ 企画書作成          進行中   │   with status
│  □ 買い物リスト作成    未着手   │   
│                                 │
├─────────────────────────────────┤
│                                 │ ← Bottom spacing
└─────────────────────────────────┘

Bottom Navigation:
┌─────────────────────────────────┐
│  🏠    📋    📅    📊    👤   │ ← Tab bar icons
│ ホーム タスク カレンダー 分析 設定│   with labels
└─────────────────────────────────┘

Design Notes:
- Current Focus: 最も重要な現在の活動を大きく表示
- Movement Alert: GPS基準の移動アラート (30分前)
- Visual Hierarchy: カード形式で情報を整理
- Tab Navigation: 5つの主要機能へのアクセス
```

### 📁 02_Screens/02_Main_Routine

#### Main_Morning_Routine  
```
Layout Structure:
┌─────────────────────────────────┐
│          07:15                  │ ← Large time display (40px)
│                                 │
│    🌅 おはようございます！      │ ← Morning greeting
│                                 │   with sunrise icon
├─────────────────────────────────┤
│                                 │
│      朝のルーティン              │ ← H2 (28px)  
│    ▓▓▓▓▓░░░░░ 5/9              │ ← Progress bar + count
│                                 │
│  ✅ 洗顔・歯磨き      5分        │ ← Completed items
│  ✅ 着替え            10分       │   with checkmarks
│  ✅ 朝食              20分       │   
│  ✅ 身だしなみ        10分       │
│  ✅ 今日の準備        15分       │
│                                 │
│  ⬜ 通勤の準備        15分       │ ← Current item  
│     残り時間: 5分               │   highlighted
│     [完了] (Primary Button)      │   large button
│                                 │
│  ⬜ 家を出る          --         │ ← Upcoming items
│  ⬜ 通勤              25分       │   grayed out  
│  ⬜ 会社到着          --         │
│                                 │
├─────────────────────────────────┤
│                                 │
│    今日も頑張りましょう！        │ ← Motivational message
│                                 │
└─────────────────────────────────┘

Design Notes:
- Morning Theme: 暖色系グラデーション背景 (#FFF3E0)
- Large Interactions: 40×40px checkboxes, 56px buttons  
- Progressive Disclosure: 現在のタスクのみ詳細表示
- Motivational: ポジティブなメッセージング
```

#### Main_Night_Routine
```
Layout Structure:  
┌─────────────────────────────────┐
│          22:30                  │ ← Large time (40px)
│                                 │
│    🌙 お疲れ様でした！          │ ← Night greeting  
│                                 │   with moon icon
├─────────────────────────────────┤
│                                 │
│       夜のルーティン             │ ← H2 (28px)
│     ▓▓▓░░░░░ 3/6               │ ← Progress bar
│                                 │
│  ✅ 入浴              30分       │ ← Completed items
│  ✅ 夕食片付け        15分       │
│  ✅ 明日の準備        15分       │
│                                 │
│  ⬜ スキンケア        10分       │ ← Current item
│     [完了] (Primary Button)      │   
│                                 │
│  ⬜ リラックスタイム   20分       │ ← Remaining items
│  ⬜ 就寝              --         │
│                                 │
├─────────────────────────────────┤
│                                 │
│      良い夢を見てください         │ ← Night message
│                                 │
└─────────────────────────────────┘

Design Notes:
- Night Theme: 寒色系グラデーション背景 (#303F9F)
- White Text: 夜間の視認性を考慮した白文字
- Calming Tone: リラックスできるメッセージング
- Same Interaction: 朝と同じUI パターン
```

### 📁 03_Daily_Planning

#### Daily_Planning_Main
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る   今日の計画   📅 10/1  │ ← Navigation header
├─────────────────────────────────┤
│    今日の計画を立てましょう      │ ← H2 Title (28px)
│   タスクを時間に配置してください │   Instruction text  
├─────────────────────────────────┤
│                                 │
│ ┌─未配置タスク─┐ ┌─今日─────┐ │ ← 2-pane layout
│ │              │ │            │ │
│ │ 📝 企画書作成 │ │ 07:00      │ │ ← Left: unscheduled
│ │ 🔸 仕事       │ │ 朝ルーティン│ │   Right: timeline
│ │ ⭐⭐⭐ 2時間  │ │            │ │
│ │              │ │ 08:30      │ │
│ │ 📧 メール返信 │ │ [空き時間] │ │ ← Drag target areas
│ │ 🔸 仕事       │ │            │ │   dotted lines
│ │ ⭐⭐ 30分    │ │ 09:00      │ │
│ │              │ │ [空き時間] │ │
│ │ 🛒 買い物     │ │            │ │
│ │ 🔸 生活       │ │ 10:00      │ │
│ │ ⭐ 1時間      │ │ 会議       │ │ ← Fixed appointments
│ │              │ │            │ │   (immovable)
│ └──────────────┘ │ 12:00      │ │
│                  │ 昼休み     │ │
│                  └────────────┘ │
├─────────────────────────────────┤
│  [🤖 AI配置]     [計画確定]    │ ← Bottom actions
│  (Secondary)     (Primary)      │   
└─────────────────────────────────┘

Design Notes:
- Drag & Drop: タスクカードを時間軸にドラッグ
- Visual Feedback: ドロップ可能エリアのハイライト
- AI Assistance: 自動配置機能でユーザー負担軽減  
- Validation: 全タスク配置まで「確定」無効化
```

### 📁 04_Schedule

#### Schedule_Timeline_View
```
Layout Structure:
┌─────────────────────────────────┐
│ 📅 2025年10月1日(火)      + ⚙️ │ ← Header with add button
├─────────────────────────────────┤
│  [日] [週] [月]                 │ ← View switcher tabs  
├─────────────────────────────────┤
│                                 │
│ 06:00 ├─睡眠────────────┤      │ ← Timeline grid
│       │                 │      │   4-layer view
│ 07:00 ├─朝ルーティン─────┤      │
│       │                 │      │
│ 08:00 ├─通勤─────┐      │      │ ← Movement blocks
│       │          │      │      │   (auto-generated)
│ 09:00 ├─────────┐│企画書│      │
│       │         ││作成  │      │ ← Task blocks
│ 10:00 │ 会議    ││      │      │   (draggable)
│       │         │└──────┤      │
│ 11:00 └─────────┘       │      │
│       ├─移動─────┐      │      │ ← Auto movement
│ 12:00 │         │昼食   │      │
│       │         │      │      │
│ 13:00 └─────────┴──────┤      │
│       ├─メール返信──────┤      │
│ 14:00 │                 │      │
│       └─────────────────┤      │
│ 15:00 ── 現在時刻 ──────────    │ ← Current time line
│                                 │   (red line)
├─────────────────────────────────┤
│   📍移動  📝タスク  📅予定  😴睡眠 │ ← Legend
└─────────────────────────────────┘

Design Notes:
- 4-Layer Display: 睡眠・予定・移動・タスクを色分け
- Current Time: 赤いラインで現在時刻を明示
- Drag & Drop: タスクの時間調整が直感的
- Auto Movement: 移動時間を自動挿入・灰色表示
```

### 📁 05_Task_Management  

#### Task_Management_Table
```
Layout Structure:
┌─────────────────────────────────┐
│  タスク管理              + 新規  │ ← Header with add button
├─────────────────────────────────┤
│ [テーブル] [カンバン] [カレンダー]│ ← View switcher  
├─────────────────────────────────┤
│  🔍 フィルター   📊 プロジェクト  │ ← Filter & project bar
│                                 │
│  ✅今日 🔸仕事 ⭐高優先         │ ← Active filters
├─────────────────────────────────┤
│                                 │
│ ┌─────┬────────┬────┬──────┐ │ ← Table headers  
│ │状態 │タスク名 │時間│優先度│ │
│ ├─────┼────────┼────┼──────┤ │
│ │ □   │📝 企画書│2h  │⭐⭐⭐ │ │ ← Task rows
│ │     │ 作成    │    │      │ │   40px height
│ ├─────┼────────┼────┼──────┤ │
│ │ ✓   │📧 メール│30m │⭐⭐   │ │ ← Completed
│ │     │ 返信    │    │      │ │   strikethrough  
│ ├─────┼────────┼────┼──────┤ │
│ │ ⏸   │🛒 買い物│1h  │⭐     │ │ ← Paused status
│ │     │         │    │      │ │
│ └─────┴────────┴────┴──────┘ │
│                                 │
├─────────────────────────────────┤
│   全15件  ✅完了:8  📋残り:7   │ ← Summary stats
└─────────────────────────────────┘

Design Notes:
- Notion-like Interface: 表形式での一覧性
- Status Icons: 直感的なステータス表示
- Project Colors: 左端にプロジェクト色バー
- Quick Actions: タップで状態変更可能
```

### 📁 06_Task_Execution

#### Task_Execution_Focus
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る        🔸 仕事           │ ← Back + project indicator
├─────────────────────────────────┤
│                                 │
│        📝 企画書作成            │ ← H1 Task title (32px)
│                                 │   Center aligned
│                                 │
│    ┌─────────────────────┐    │ ← Timer section  
│    │                     │    │   Large display
│    │       01:23:45      │    │   
│    │     / 02:00:00      │    │   Current / Planned  
│    │                     │    │
│    │  ▓▓▓▓▓▓▓░░░ 70%    │    │   Progress bar
│    └─────────────────────┘    │
│                                 │
│        📍 自宅オフィス          │ ← Location status
│         🔋 集中モード           │   Focus mode indicator
│                                 │
├─────────────────────────────────┤
│                                 │
│  ┌─────┐  ┌─────┐  ┌─────┐   │ ← Action buttons
│  │⏸️   │  │✅    │  │⏹️    │   │   Large & accessible
│  │一時 │  │完了  │  │中断  │   │   56px × 80px
│  │停止 │  │     │  │     │   │
│  └─────┘  └─────┘  └─────┘   │
│                                 │
└─────────────────────────────────┘

Design Notes:
- Full Screen Focus: 実行中タスクに完全フォーカス
- Large Timer: 時間が明確に視認できる大きな表示
- Project Color: 背景にプロジェクト色を薄く適用
- Minimal Distraction: 必要最小限のUI要素
```

### 📁 07_Settings  

#### Settings_Main
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る         設定             │ ← Navigation header
├─────────────────────────────────┤
│                                 │
│  👤 田中太郎                    │ ← User profile section
│      📧 tanaka@example.com      │   Name + email
│      [プロフィール編集]          │   Edit button
│                                 │
├─────────────────────────────────┤
│                                 │
│  ⚙️ アプリ設定                 │ ← Settings sections
│                                 │
│  📍 位置・移動設定              │ ← GPS settings
│       GPS精度: 高精度     >     │   Current setting
│                                 │
│  🔔 通知設定                    │ ← Notification settings  
│       移動アラート: ON    >     │   Toggle states
│                                 │
│  🎨 表示設定                    │ ← Display settings
│       テーマ: システム     >     │   Theme selection
│                                 │
│  ♿ アクセシビリティ            │ ← Accessibility  
│       文字サイズ: 大     >      │   Font size etc.
│                                 │
├─────────────────────────────────┤
│                                 │  
│  📊 データ・プライバシー        │ ← Data section
│                                 │
│  💾 データエクスポート          │ ← Export function
│  🗑️ データ削除                │ ← Delete data  
│  📋 プライバシーポリシー        │ ← Legal links
│  📜 利用規約                    │
│                                 │
├─────────────────────────────────┤
│                                 │
│  🚪 [ログアウト]               │ ← Logout button  
│                                 │   Red text color
└─────────────────────────────────┘

Design Notes:
- Grouped Settings: 機能ごとにセクション分け
- Current Values: 現在の設定値を表示
- Clear Hierarchy: アイコン + ラベルで分かりやすく
- Dangerous Actions: ログアウト・削除は赤色
```

### 📁 08_Review

#### Daily_Review_Summary  
```
Layout Structure:
┌─────────────────────────────────┐
│ ← 戻る    今日の振り返り         │ ← Navigation header  
│                📅 10/1(火)     │   Date indicator
├─────────────────────────────────┤
│         お疲れ様でした！         │ ← H2 Greeting (28px)
│                                 │
│  ┌─────────────────────────┐  │ ← Achievement card
│  │  🎯 今日の達成度          │  │   
│  │                         │  │
│  │     ▓▓▓▓▓▓▓▓░░ 80%     │  │   Progress visualization
│  │                         │  │
│  │  ✅ 完了: 8件           │  │   Task completion stats
│  │  ⏸️ 未完了: 2件         │  │
│  └─────────────────────────┘  │
│                                 │
│  ⏱️ 時間の使い方               │ ← H3 Time analysis  
│                                 │
│  ┌─────────────────────────┐  │ ← Pie chart section
│  │       円グラフ           │  │   
│  │   🔸 仕事: 4h (50%)     │  │   Project color coding
│  │   🔸 生活: 2h (25%)     │  │   
│  │   🔸 移動: 1h (12.5%)   │  │
│  │   🔸 休憩: 1h (12.5%)   │  │
│  └─────────────────────────┘  │
│                                 │
├─────────────────────────────────┤
│                                 │
│  💭 今日の振り返り              │ ← H3 Reflection (24px)
│                                 │
│  今日はどうでしたか？           │ ← Simple question
│                                 │
│  😊  😐  😔                   │ ← Mood selector  
│  良い 普通 疲れた               │   3 emotions
│                                 │
│  ┌─────────────────────────┐  │ ← Text input
│  │ 特に良かったこと、        │  │   Optional notes
│  │ 改善したいことがあれば... │  │   
│  └─────────────────────────┘  │
│                                 │
├─────────────────────────────────┤
│        [振り返り完了]            │ ← Submit button
└─────────────────────────────────┘

Design Notes:
- Positive Framing: 「お疲れ様」で労いの気持ち
- Visual Data: 円グラフで時間配分を直感的に表示  
- Simple Input: 3段階の感情選択で負担軽減
- Optional Text: 詳細コメントは任意で心理的負担なし
```

---

## 📋 User Flow Wireframes 

### 📁 03_User_Flows/Morning_Routine_Flow

#### Morning_Flow_Complete
```
User Journey Map:
┌─────────────────────────────────┐
│ 06:50: アラーム・起床           │
│  ↓ (アプリ自動起動)             │
│                                 │
│ [朝ルーティン開始画面]          │ ← Auto-triggered by time
│  🌅 おはようございます         │
│  今日のルーティンを始めましょう │
│  [開始する] (Primary Button)    │
│  ↓                             │
│                                 │
│ [ルーティン実行画面]            │ ← Step-by-step execution
│  ✅ 洗顔・歯磨き (完了)        │
│  ▶️ 着替え (実行中)            │   Current item highlighted
│     残り予定時間: 8分           │   Time guidance
│  ⬜ 朝食 (待機中)              │
│  [完了] ボタン                  │
│  ↓                             │
│                                 │
│ [自動進行]                      │ ← Next item auto-focus  
│  ▶️ 朝食 (実行中)              │
│     残り予定時間: 15分          │
│  [完了] ボタン                  │
│  ↓                             │
│                                 │
│ [ルーティン完了画面]            │ ← Completion celebration
│  🎉 朝のルーティン完了！        │
│  かかった時間: 42分 (予定45分)  │
│                                 │
│  次は今日の計画を立てましょう   │
│  [デイリープランニングへ]        │
└─────────────────────────────────┘

Flow Annotations:
- Auto-trigger: 起床時間の±30分で自動表示
- Progressive: 一つずつ順番に実行・次へ自動遷移  
- Time Tracking: 各項目の実行時間を記録・学習
- Positive Reinforcement: 完了時に達成感を演出
```

### 📁 03_User_Flows/Daily_Planning_Flow

#### Daily_Planning_Complete
```
User Journey Map:
┌─────────────────────────────────┐
│ 08:15: ルーティン完了後の自動遷移│
│  ↓                             │
│                                 │
│ [プランニング開始画面]          │ ← Mandatory daily planning
│  📅 今日の計画を立てましょう    │
│  スキップはできません           │   Non-skippable
│  [始める] (Primary Button)      │
│  ↓                             │
│                                 │  
│ [タスク配置画面]                │ ← Drag & drop interface
│  未配置: 📝企画書、📧メール等   │   Left panel: tasks
│  時間軸: 空き時間を点線表示     │   Right panel: timeline
│                                 │
│  User Action: ドラッグ&ドロップ │ ← User interaction
│  ↓                             │
│                                 │
│ [配置プレビュー]                │ ← Real-time feedback  
│  ドロップエリアがハイライト     │
│  時間調整の自動計算表示         │
│  ↓                             │
│                                 │
│ [AI配置提案] (オプション)       │ ← AI assistance option
│  🤖 最適な配置を提案します      │
│  集中力の波を考慮した時間割     │
│  [AI配置を適用] [自分で配置]   │
│  ↓                             │
│                                 │
│ [配置完了確認]                  │ ← Validation screen
│  全てのタスクが配置されました   │
│  予定通り: 18:30終了予定        │
│                                 │
│  [計画確定] (Primary Button)    │ ← Final confirmation  
│  ↓                             │
│                                 │
│ [プランニング完了]              │ ← Success & transition
│  ✅ 今日の計画が完成！          │
│  それでは頑張りましょう！       │
│  [メイン画面へ] → 通常モード    │
└─────────────────────────────────┘

Flow Annotations:
- Mandatory: 朝ルーティン後は必ずプランニング実行
- Guided: ドラッグ&ドロップを直感的にガイド
- AI Support: 困った時のAI自動配置オプション  
- Validation: 全タスク配置まで先に進めない
```

### 📁 03_User_Flows/Task_Execution_Flow

#### Task_Execution_Complete  
```  
User Journey Map:
┌─────────────────────────────────┐
│ 10:00: 予定されたタスク開始時刻 │
│  ↓ (プッシュ通知)               │
│                                 │
│ [タスク開始通知]                │ ← Automatic notification
│  📝 企画書作成の時間です        │
│  予定: 2時間                    │
│  [開始] [10分後] [スキップ]    │
│  ↓                             │
│                                 │
│ [実行画面]                      │ ← Full-screen focus mode
│  📝 企画書作成                  │   Task title prominent
│  01:23:45 / 02:00:00           │   Timer display
│  ▓▓▓▓▓▓▓░░░ 70%               │   Progress bar
│                                 │
│  📍 自宅オフィス                │   Location tracking
│  🔋 集中モード ON               │   Focus mode status  
│                                 │
│  [⏸️一時停止] [✅完了] [⏹️中断] │   Large action buttons
│  ↓                             │
│                                 │
│ [一時停止時]                    │ ← Pause handling
│  ⏸️ 一時停止中                  │
│  休憩理由: [トイレ] [飲み物]    │   Quick reason selection
│  [再開] [完了] [中断]          │
│  ↓                             │
│                                 │
│ [完了時]                        │ ← Completion celebration
│  🎉 タスク完了！                │
│  実行時間: 1時間48分            │   Actual vs planned
│  予定時間: 2時間 (-12分早い)   │   
│                                 │
│  どうでしたか？                 │   Quick feedback
│  😊 順調 😐 普通 😔 大変      │   3-point scale
│                                 │  
│  [次のタスクへ] [休憩]         │   Next action choice
│  ↓                             │
│                                 │
│ [学習・改善提案]                │ ← AI-powered insights
│  このタスクは想定より早く       │
│  完了できています！             │   Positive reinforcement
│                                 │
│  💡 改善提案                    │
│  似たタスクの予定時間を         │   Learning suggestions
│  1.8時間に調整しますか？       │
│  [はい] [いいえ]               │
└─────────────────────────────────┘

Flow Annotations:  
- Proactive Notifications: 開始時刻に自動通知
- Full Focus Mode: 実行中は他の情報を隠しミニマル表示
- Easy Pause/Resume: 休憩を取りやすい設計
- Learning Loop: 実績から次回の予定時間を改善提案
```

---

## 🔄 Interactive Prototype Links

### 📁 04_Prototype

#### Prototype_Navigation_Map
```
Figma Prototype Flow:
┌─────────────────────────────────┐
│  [Start] Onboarding Screen 1    │
│    ↓ (Auto-advance 3s)         │
│  Onboarding Screen 2            │  
│    ↓ (Tap "Next")              │
│  Onboarding Screen 3            │
│    ↓ (Tap "Get Started")       │
│  Setup Flow (6 screens)         │
│    ↓ (Complete setup)          │
│  Main Dashboard                 │
│    ↓ (Time-based routing)      │
│                                 │
│  ┌─Morning Mode────┐           │ ← Time-based branches
│  │ (6:00-8:00)     │           │
│  │ Routine Screens │           │  
│  └─────────────────┘           │
│           ↓                    │
│  ┌─Planning Mode───┐           │
│  │ (8:00-10:00)    │           │ 
│  │ Daily Planning  │           │
│  └─────────────────┘           │
│           ↓                    │  
│  ┌─Normal Mode─────┐           │
│  │ (10:00-22:00)   │           │
│  │ Task Management │           │
│  │ Schedule View   │           │
│  │ Focus Mode      │           │
│  └─────────────────┘           │
│           ↓                    │
│  ┌─Night Mode──────┐           │ 
│  │ (22:00-24:00)   │           │
│  │ Night Routine   │           │
│  │ Daily Review    │           │
│  └─────────────────┘           │
└─────────────────────────────────┘

Prototype Features:
- Auto-advance: オンボーディングのタイミング制御
- Time Simulation: 時間帯別モード切り替えのデモ
- Drag & Drop: プランニング画面のインタラクション
- State Management: タスク完了状態の保持・遷移
- Navigation: タブ切り替え・画面遷移の動作確認
```

#### Interactive_Components_Demo
```
Component Interactions:
┌─────────────────────────────────┐
│  📱 Button States Demo          │ ← Component state variations
│   [Default] [Hover] [Pressed]   │
│   [Disabled] states             │
│                                 │  
│  ✅ Checkbox Interactions       │ ← Checkbox state changes
│   □ Unchecked                   │
│   ☑️ Checked                     │   
│   ⬜ Disabled                   │
│                                 │
│  🎛️ Toggle Switches            │ ← Settings toggles
│   GPS: ●——○ ON                 │
│   通知: ○——● OFF                │
│                                 │
│  📊 Progress Animations         │ ← Animated progress  
│   ▓▓▓▓░░░░░░ 40%               │   bars & counters
│   Loading... ⭕                 │
│                                 │
│  🕐 Timer Components            │ ← Timer animations
│   01:23:45 (counting up)        │
│   -00:12:34 (countdown)         │
│                                 │
│  🎨 Color Picker Demo           │ ← Project color selection
│   🔴🟠🟡🟢🔵🟣🟤⚫          │   8-color palette
└─────────────────────────────────┘

Micro-interactions:
- Button Press: 0.1s scale transform + haptic
- Checkbox: Checkmark draw animation 0.3s
- Progress Bar: Smooth width transition 0.5s  
- Page Transition: Slide + fade 0.3s ease-out
- Loading States: Skeleton loading → content fade-in
```

---

## 📝 Design Guidelines & Specifications

### アクセシビリティ配慮
```
認知特性対応デザインルール:

1. 情報量の制限
   - 1画面1機能の原則
   - 重要情報は上部1/3に配置
   - 同時表示項目は7±2個まで

2. 視覚的明確性  
   - 十分なコントラスト比 (WCAG AA準拠)
   - 境界線の明確化 (2px以上)
   - 重要情報は色+形状+文字で三重表現

3. 操作性の向上
   - タップターゲット 44×44px以上
   - 誤操作防止の余白確保
   - 戻る操作の一貫性

4. 時間感覚の支援
   - 大きな時計表示 (32px以上)
   - 残り時間の視覚化
   - 進捗の分かりやすい表現

5. 認知負荷の軽減
   - 専門用語の回避・平易な表現
   - アイコン+テキストの併記
   - 段階的な情報開示
```

### レスポンシブ対応
```
画面サイズ別レイアウト:

📱 Phone (320-414px):
- 1カラムレイアウト
- タブナビゲーション (bottom)
- カードは縦並び
- テキストサイズ18px+

📱 Large Phone (414-768px):  
- 基本は1カラム
- 横並び可能な場所は2カラム化
- より多くの情報表示

🖥️ Tablet (768px+):
- 2カラムレイアウト活用
- サイドナビゲーション
- Drag&Drop操作の最適化  
- テキストサイズ据え置き
```

### ダークモード対応
```
Night Theme Colors:

Background Colors:
- Primary: #121212 (Dark surface)
- Secondary: #1E1E1E (Cards)
- Tertiary: #2D2D2D (Elevated surfaces)

Text Colors:  
- Primary: #FFFFFF (87% opacity)
- Secondary: #FFFFFF (60% opacity)
- Disabled: #FFFFFF (38% opacity)

Accent Colors:
- 基本的にライトモードと同じ
- 必要に応じて彩度を下げる
- 夜間の視認性を考慮した調整

Night Mode Rules:
- 22:00以降は自動切り替え
- ルーティンモード時は強制適用  
- 目に優しい暖色系アクセント使用
```

---

**更新履歴:**
- 2025年9月30日: 初版作成・全画面ワイヤーフレーム設計完了
- 定期見直し: ユーザビリティテスト結果に基づく改善